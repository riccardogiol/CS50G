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

Player = Class{}

function Player:init(paddle, score)
	self.paddle = paddle
	self.score = score 
end

function love.load()
	love.graphics.setDefaultFilter('nearest', 'nearest')
	love.window.setTitle('Pong by RG')

	math.randomseed(os.time())

	smallFont = love.graphics.newFont('font.ttf', 8)
	scoreFont = love.graphics.newFont('font.ttf', 32)

	push:setupScreen(virtual_width, virtual_height, window_width, window_hight, {fullscreen = false, resizable = false, vsync = true})

	--initialize game variables
	playground_top = top_banner_high + playground_dist_from_bord
	playground_bottom = virtual_height - playground_dist_from_bord
	playground = Playground(0,
		virtual_width,
		playground_top,
		playground_bottom,
		1)

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

	player1 = Player(paddle1, 0)
	player2 = Player(paddle2, 0)

	ball = Ball(virtual_width / 2 - 2,
		(playground_top + (playground_bottom - playground_top) / 2) - 2, 
		4,
		4, 
		0,
		0)

	gameState = 'ready'
	serveState = 'nobody'
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
		if ball:outL(playground) then
			player2.score = player2.score + 1
			enterReadyState()
			serveState = 'player1'
		elseif ball:outR(playground) then
			player1.score = player1.score + 1
			enterReadyState()
			serveState = 'player2'
		end
	end
end


function love.keypressed(key)
	if key == 'escape' then
		love.event.quit()
	end

	if (key == 'enter' or key == 'return') and gameState == 'ready' then
		if serveState == 'nobody' then
			ballDX = math.random(2) == 1 and 100 or -100
		elseif serveState == 'player1' then
			ballDX = -100
		elseif serveState == 'player2' then
			ballDX = 100
		end
		ballDY = math.random(-50, 50) * 1.5
		ball:setSpeed(ballDX, ballDY)
		gameState = 'play'
	elseif (key == 'enter' or key == 'return') and gameState == 'play' then
		enterReadyState()
	end
end

function enterReadyState()
	ball:setPosition(virtual_width / 2 - 2,  (playground_top + (playground_bottom - playground_top) / 2) - 2)
	ball:setSpeed(0,0)
	gameState = 'ready'
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

	if gameState == 'ready' then
		if serveState == 'nobody' then
			love.graphics.printf("Ready to start!", 0, 15, virtual_width, 'center')
		else 
			love.graphics.printf("Ready to start, serve " .. tostring(serveState) .. "!", 0, 15, virtual_width, 'center')
		end
	elseif gameState == 'play' then
		love.graphics.printf("Play!", 0, 15, virtual_width, 'center')
	end

	love.graphics.setFont(scoreFont)
	love.graphics.printf(tostring(player1.score), 0, 5, virtual_width / 2 - 30, 'center')
	love.graphics.printf(tostring(player2.score), virtual_width / 2 + 30, 5, virtual_width / 2 - 30, 'center')
end

function displayFPS()
	love.graphics.setFont(smallFont)
	love.graphics.print('FPS ' .. tostring(love.timer.getFPS()), 5, 5)
end

