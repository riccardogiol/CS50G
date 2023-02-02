push = require 'push'
Class = require 'class'

require 'GroundImage'
require 'Bird'
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
	bird = Bird('images/bird.png', virtual_width/2, virtual_height/2, 300, 180)

	love.keyboard.keypressed = {}
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
	love.keyboard.keypressed[key] = true

	if key == 'escape' then
		love.event.quit()
	end
end

function love.keyboard.wasPressed(key)
	if love.keyboard.keypressed[key] then
		love.keyboard.keypressed[key] = false
		return true
	else
		return false
	end
end


function love.update(dt)
	--update images position 
	background:updatePosition(dt)
	foreground:updatePosition(dt)
	--update bird position
	bird:updatePosition(dt)
end

function love.draw()
	push:start()
	--draw image
	background:render()
	foreground:render()
	bird:render()

	push:finish()
end
