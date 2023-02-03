push = require 'push'
Class = require 'class'

require 'StateMachine'

require 'states/BaseState'
require 'states/PlayState'
require 'states/ScoreState'

require 'GroundImage'
require 'Bird'
require 'Pipe'

window_width = 1280
window_height = 720

virtual_width = 512
virtual_height = 288

function love.load()
	love.graphics.setDefaultFilter('nearest', 'nearest')
	math.randomseed(os.time())
	love.window.setTitle('Bird by RG')

	smallFont = love.graphics.newFont('font.ttf', 8)
	bigFont = love.graphics.newFont('font.ttf', 32)

	push:setupScreen(virtual_width,
		virtual_height,
		window_width,
		window_height, 
		{fullscreen = false,
		resizable = true,
		vsync = true})

	--initiate global objects of the game 
	gBackground = GroundImage('images/background.png', 30, 413, 0, 0)
	gForeground = GroundImage('images/ground.png', 60, virtual_width, 0, virtual_height-16)	
	gBird = Bird('images/bird.png', virtual_width/2, virtual_height/2, 300, 150)
	gPipes_pairs = {}

	gStateMachine = StateMachine {
		['score'] = function() return ScoreState() end,
		['play'] = function() return PlayState() end,
	}

	gStateMachine:change('play')

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
	gStateMachine.current:update(dt)
end

function love.draw()
	push:start()
	--draw image
	gStateMachine.current:render()

	displayFPS()
	push:finish()
end

function displayFPS()
	love.graphics.setFont(smallFont)
	love.graphics.print('FPS ' .. tostring(love.timer.getFPS()), 5, 5)
end

