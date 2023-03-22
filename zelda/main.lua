require 'src/Dependencies'


function love.load()
	push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
		fullscreen = false,
		vsync = true,
		resizable = true
	})
    math.randomseed(os.time())

    love.keyboard.keyPressed = {}

	gStateMachine = StateMachine ({
		['play'] = function() return PlayState() end
	})
	gStateMachine:change('play')
end

function love.resize(w, h)
	push:resize(w, h)
end

function love.keypressed(key)
	love.keyboard.keyPressed[key] = true
end

function love.keyboard.wasPressed(key)
	return love.keyboard.keyPressed[key]
end

function love.update(dt)
	Timer.update(dt)
	gStateMachine:update(dt)
	love.keyboard.keyPressed = {}
end

function love.draw()
	push:start()
	--local start_time = os.clock()
	gStateMachine:render()
	-- local end_time = os.clock()
	-- local elapsed_time = end_time - start_time

	love.graphics.setColor(1, 0, 1, 1)
	love.graphics.setFont(gFonts['small'])
	love.graphics.print(love.timer.getFPS(), 2, 2)
	--love.graphics.print(elapsed_time, 2, 10)
	push:finish()
end