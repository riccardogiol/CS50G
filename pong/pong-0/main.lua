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

	smallFont = love.graphics.newFont('font.ttf', 8)
	scoreFont = love.graphics.newFont('font.ttf', 32)

	push:setupScreen(virtual_width, virtual_height, window_width, window_hight, {fullscreen = false, resizable = false, vsync = true})

	--initialize some variables
	p1score = 0 
	p2score = 13

	p1Y = top_banner_high+playground_dist_from_bord +10
	p2Y = virtual_height - playground_dist_from_bord - 20 - 10

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
end


function love.keypressed(key)
	if key == 'escape' then
		love.event.quit()
	end
end


function love.draw()
	push:apply('start')

	love.graphics.clear(40/255, 45/255, 52/255, 200/255)

	love.graphics.setFont(smallFont)
	love.graphics.printf(string.format("Hi, it's me %s!", my_name), 0, 10, virtual_width, 'center')

	love.graphics.setFont(scoreFont)
	love.graphics.printf(tostring(p1score), 0, 10, virtual_width / 2 - 30, 'center')
	love.graphics.printf(tostring(p2score), virtual_width / 2 + 30, 10, virtual_width / 2 - 30, 'center')

	love.graphics.rectangle('fill', paddle_dist_from_bord, p1Y, 5, 20)
	love.graphics.rectangle('fill', virtual_width - paddle_dist_from_bord - 5, p2Y, 5, 20)
	love.graphics.rectangle('fill', virtual_width / 2 - 2, virtual_height / 2 - 2, 4, 4)

	push:apply('end')
end
