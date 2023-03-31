require 'src/dependencies'

function love.load()
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
	love.graphics.setColor(1, 0, 1, 1)
	love.graphics.setFont(gFonts['small'])
	love.graphics.print(tostring(love.timer.getFPS()), 2, 2)
	push:finish()
end