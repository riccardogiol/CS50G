push = require 'push'
Class = require 'class'

require 'GroundImage'
--require 'Bird'
--require 'Pipe'

window_width = 1280
window_height = 720

virtual_width = 512
virtual_height = 288


function love.load()
	love.graphics.setDefaultFilter('nearest', 'nearest')

	push:setupScreen(virtual_width,
		virtual_height,
		window_width,
		window_height, 
		{fullscreen = false,
		resizable = true,
		vsync = true})

	--initiate images with speed
	background = GroundImage('images/background.png', 30, 413, 0, 0)
	foreground = GroundImage('images/ground.png', 60, virtual_width, 0, virtual_height-16)
	--initiate bird
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
	if key == 'escape' then
		love.event.quit()
	end
end


function love.update(dt)
	--update images position 
	background:updatePosition(dt)
	foreground:updatePosition(dt)
	--update
end

function love.draw()
	push:start()
	--draw image
	background:render()
	foreground:render()
	push:finish()
end
