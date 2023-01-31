push = require 'push'
Class = require 'class'

require 'Paddle'
require 'Playground'
require 'Ball'

-- declare some constants
my_name = "Pong"
window_width = 1280
window_hight = 720

virtual_width = 432
virtual_height = 243

paddle_dist_from_bord = 20
top_banner_high = 30
playground_dist_from_bord = 10

paddle_width = 5
paddle_height = 30
paddle_speed = 200

function love.load()
	love.graphics.setDefaultFilter('nearest', 'nearest')
	love.window.setTitle('Pong by RG')

	math.randomseed(os.time())

	smallFont = love.graphics.newFont('font.ttf', 8)
	scoreFont = love.graphics.newFont('font.ttf', 32)

	push:setupScreen(virtual_width, virtual_height, window_width, window_hight, {fullscreen = false, resizable = false, vsync = true})

	--initialize game variables
	playground = Playground(0, virtual_width, top_banner_high + playground_dist_from_bord, virtual_height - playground_dist_from_bord, 1)

	p1score = 0
	p2score = 0

	paddle1 = Paddle(paddle_dist_from_bord,
		top_banner_high+playground_dist_from_bord +10,
		paddle_width,
		paddle_height,
		paddle_speed,
		top_banner_high + playground_dist_from_bord,
		virtual_height - playground_dist_from_bord)
	paddle2 = Paddle(virtual_width - paddle_dist_from_bord - paddle_width,
		virtual_height - playground_dist_from_bord - paddle_height - 10,
		paddle_width,
		paddle_height,
		paddle_speed,
		top_banner_high + playground_dist_from_bord,
		virtual_height - playground_dist_from_bord)

	ball = Ball(virtual_width / 2 - 2,
		((virtual_height - playground_dist_from_bord - (top_banner_high + playground_dist_from_bord)) / 2) + top_banner_high + playground_dist_from_bord - 2, 
		4,
		4, 
		0,
		0)

	gameState = 'start'
end

function love.update(dt)
	if love.keyboard.isDown('w') then
		paddle1:updatePosition(dt, 'up') 
	elseif love.keyboard.isDown('s') then
		paddle1:updatePosition(dt, 'down')
	end

	if love.keyboard.isDown('up') then
		paddle2:updatePosition(dt, 'up') 
	elseif love.keyboard.isDown('down') then
		paddle2:updatePosition(dt, 'down')
	end

	if gameState == 'play' then
		ball:updatePosition(dt, paddle1, paddle2, playground)
	end
end


function love.keypressed(key)
	if key == 'escape' then
		love.event.quit()
	end

	if (key == 'enter' or key == 'return') and gameState == 'start' then
		ballDX = math.random(2) == 1 and 100 or -100
		ballDY = math.random(-50, 50) * 1.5
		ball:setSpeed(ballDX, ballDY)
		gameState = 'play'
	elseif (key == 'enter' or key == 'return') and gameState == 'play' then
		ball:setPosition(virtual_width / 2 - 2, ((virtual_height - playground_dist_from_bord - (top_banner_high + playground_dist_from_bord)) / 2) + top_banner_high + playground_dist_from_bord - 2)
		ball:setSpeed(0,0)
		gameState = 'start'
	end
end


function love.draw()
	push:apply('start')
	love.graphics.clear(40/255, 45/255, 52/255, 255/255)

	-- draw top banner
	drawBanner()
	displayFPS()

	--draw playground
	playground:render()

	paddle1:render()
	paddle2:render()

	ball:render()

	push:apply('end')
end

function drawBanner()
	love.graphics.setFont(smallFont)
	love.graphics.printf(string.format("Hi, it's me %s!", my_name), 0, 5, virtual_width, 'center')
	if gameState == 'start' then
		love.graphics.printf("Ready to start!", 0, 15, virtual_width, 'center')
	elseif gameState == 'play' then
		love.graphics.printf("Play!", 0, 15, virtual_width, 'center')
	end

	love.graphics.setFont(scoreFont)
	love.graphics.printf(tostring(p1score), 0, 5, virtual_width / 2 - 30, 'center')
	love.graphics.printf(tostring(p2score), virtual_width / 2 + 30, 5, virtual_width / 2 - 30, 'center')
end

function displayFPS()
	love.graphics.setFont(smallFont)
	love.graphics.print('FPS ' .. tostring(love.timer.getFPS()), 5, 5)
end

