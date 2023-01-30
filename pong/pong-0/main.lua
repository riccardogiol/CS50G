push = require 'push'

my_name = "Riccardo"
window_width = 1280
window_hight = 720

virtual_width = 432
virtual_height = 243

paddle_dist_from_bord = 20
top_banner_high = 30
playground_dist_from_bord = 20

function love.load()
	love.graphics.setDefaultFilter('nearest', 'nearest')

	smallFont = love.graphics.newFont('font.ttf', 8)
	love.graphics.setFont(smallFont)

	push:setupScreen(virtual_width, virtual_height, window_width, window_hight, {fullscreen = false, resizable = false, vsync = true})
end

function love.keypressed(key)
	if key == 'escape' then
		love.event.quit()
	end
end


function love.draw()
	push:apply('start')

	love.graphics.clear(40/255, 45/255, 52/255, 200/255)
	love.graphics.printf(string.format("Hi, it's me %s!", my_name), 0, 10, virtual_width, 'center')

	love.graphics.rectangle('fill', paddle_dist_from_bord, top_banner_high+playground_dist_from_bord +10, 5, 20)
	love.graphics.rectangle('fill', virtual_width - paddle_dist_from_bord - 5, virtual_height - playground_dist_from_bord - 30, 5, 20)
	push:apply('end')
end
