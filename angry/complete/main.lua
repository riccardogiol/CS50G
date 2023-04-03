require 'src/dependencies'

function love.load()
	push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        vsync = true,
        resizable = false
    })

    gStateMachine = StateMachine ({
    	['start'] = function() return StartState() end,
    	['play'] = function() return PlayState() end
    })
    gStateMachine:change('start')

	love.keyboard.keypressed = {}
	love.mouse.keypressed = {}
	love.mouse.keyreleased = {}

	paused = false
end

function love.keypressed(key) 
	love.keyboard.keypressed[key] = true
	if key == 'p' then
		paused = not paused
	end
end

function love.mousepressed(x, y, button)
	love.mouse.keypressed[button] = true
end

function love.mousereleased(x, y, button)
	love.mouse.keyreleased[button] = true
end


function love.update(dt)
	if not paused then
		gStateMachine:update(dt)

		love.keyboard.keypressed = {}
		love.mouse.keypressed = {}
		love.mouse.keyreleased = {}
	end
end

function love.draw()
	push:start()
	gStateMachine:render()
	love.graphics.setColor(1, 0, 1, 1)
	love.graphics.setFont(gFonts['small'])
	love.graphics.print(tostring(love.timer.getFPS()), 2, 2)
	push:finish()
end