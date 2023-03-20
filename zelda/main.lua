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
	gStateMachine:render()
	push:finish()
end