push = require 'push'
Class = require 'class'

require 'GroundImage'
require 'Bird'
require 'Pipe'

window_width = 1280
window_height = 720

virtual_width = 512
virtual_height = 288

local pipes = {}
local pipe_image = love.graphics.newImage('images/pipe.png')
pipe_offset = 100
number_of_pipes = 0

function love.load()
	love.graphics.setDefaultFilter('nearest', 'nearest')
	math.randomseed(os.time())

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
	--initiate pipes

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
	--update pipes list
	if lastPipeDistance() > pipe_offset then
		new_y = math.random(virtual_height / 4, virtual_height - 20)
		newPipe = Pipe(pipe_image, virtual_width, new_y, 60)
		table.insert(pipes, newPipe)
	end

	--update pipes position and delete if no more visible
	number_of_pipes = 0
	for k, pipe in pairs(pipes) do
		pipe:updatePosition(dt)
		number_of_pipes = number_of_pipes + 1
	end
	--remove the pipe on the left out of the update cycle otherwise glitch
	for k, pipe in pairs(pipes) do
		if pipe:isOutL() then
			table.remove(pipes, k)
		end
	end

end

function lastPipeDistance()
	x_max = 0
	for k, pipe in pairs(pipes) do
		if pipe.x > x_max then
			x_max = pipe.x 
		end
	end

	return virtual_width - x_max
end

function love.draw()
	push:start()
	--draw image
	background:render()
	foreground:render()
	bird:render()
	for k, pipe in pairs(pipes) do
		pipe:render()
	end
	--love.graphics.print(tostring(number_of_pipes), 0, 0)

	push:finish()
end
