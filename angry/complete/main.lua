require 'src/dependencies'

function love.load()
	love.graphics.setDefaultFilter('nearest', 'nearest')
	push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        vsync = true,
        resizable = false
    })

    gStateMachine = StateMachine ({
    	['start'] = function() return StartState() end
    })
    gStateMachine:change('start')

	love.keyboard.keypressed = {}
end

function love.keypressed(key) 
	love.keyboard.keypressed[key] = true
end


function love.update(dt)
	gStateMachine:update(dt)

	love.keyboard.keypressed = {}
end

function love.draw()
	push:start()
	gStateMachine:render()
	push:finish()
end