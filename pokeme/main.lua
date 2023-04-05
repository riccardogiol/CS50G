require 'src/dependencies'

function love.load()
	push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        vsync = true,
        resizable = false
    })

    gStateStack = StateStack()
    gStateStack:push(StartState())

    love.keyboard.keypressed = {}
end

function love.keypressed(key)
	if key == 'escape' then
		love.event.quit()
	end
	love.keyboard.keypressed[key] = true
end

function love.update(dt)
	Timer.update(dt)
	gStateStack:update(dt)

   love.keyboard.keypressed = {}
end


function love.draw()
	push:start()
	gStateStack:render()
	love.graphics.setFont(gFonts['small'])
	love.graphics.setColor(0, 1, 0, 1)
	love.graphics.print("FPS: " .. tostring(love.timer.getFPS()), 2, 2)
	push:finish()
end