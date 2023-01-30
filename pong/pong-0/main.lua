push = require 'push'

-- declare some constants
my_name = "Riccardo"
window_width = 1280
window_hight = 720

virtual_width = 432
virtual_height = 243

paddle_dist_from_bord = 20
top_banner_high = 30
playground_dist_from_bord = 20

paddle_speed = 200

function love.load()
	love.graphics.setDefaultFilter('nearest', 'nearest')

	math.randomseed(os.time())

	smallFont = love.graphics.newFont('font.ttf', 8)
	scoreFont = love.graphics.newFont('font.ttf', 32)

	push:setupScreen(virtual_width, virtual_height, window_width, window_hight, {fullscreen = false, resizable = false, vsync = true})

	--initialize some variables
	p1score = 0 
	p2score = 13

	p1Y = top_banner_high+playground_dist_from_bord +10
	p2Y = virtual_height - playground_dist_from_bord - 20 - 10

	ballX = virtual_width / 2 - 2
	ballY = virtual_height / 2 - 2

	ballDX = 0
	ballDY = 0

	gameState = 'start'
end

function love.update(dt)
	if love.keyboard.isDown('w') then
		p1Y = p1Y - paddle_speed * dt 
	elseif love.keyboard.isDown('s') then
		p1Y = p1Y + paddle_speed * dt 
	end

	if love.keyboard.isDown('up') then
		p2Y = p2Y - paddle_speed * dt 
	elseif love.keyboard.isDown('down') then
		p2Y = p2Y + paddle_speed * dt 
	end

	if gameState == 'play' then
		ballX = ballX + ballDX * dt
		ballY = ballY + ballDY * dt
	end
end


function love.keypressed(key)
	if key == 'escape' then
		love.event.quit()
	end

	if (key == 'enter' or key == 'return') and gameState == 'start' then
		ballDX = math.random(2) == 1 and 100 or -100
		ballDY = math.random(-50, 50) * 1.5
		gameState = 'play'
	elseif (key == 'enter' or key == 'return') and gameState == 'play' then
		ballX = virtual_width / 2 - 2
		ballY = virtual_height / 2 - 2
		ballDX = 0
		ballDY = 0
		gameState = 'start'
	end
end


function love.draw()
	push:apply('start')

	love.graphics.clear(40/255, 45/255, 52/255, 200/255)

	love.graphics.setFont(smallFont)
	love.graphics.printf(string.format("Hi, it's me %s!", my_name), 0, 10, virtual_width, 'center')
	if gameState == 'start' then
		love.graphics.printf("Ready to start!", 0, 20, virtual_width, 'center')
	elseif gameState == 'play' then
		love.graphics.printf("Play!", 0, 20, virtual_width, 'center')
	end

	love.graphics.setFont(scoreFont)
	love.graphics.printf(tostring(p1score), 0, 10, virtual_width / 2 - 30, 'center')
	love.graphics.printf(tostring(p2score), virtual_width / 2 + 30, 10, virtual_width / 2 - 30, 'center')

	love.graphics.rectangle('fill', paddle_dist_from_bord, p1Y, 5, 20)
	love.graphics.rectangle('fill', virtual_width - paddle_dist_from_bord - 5, p2Y, 5, 20)
	love.graphics.rectangle('fill', ballX, ballY, 4, 4)

	push:apply('end')
end
