require 'src/Dependencies'

function love.load()
	love.graphics.setDefaultFilter('nearest', 'nearest')
	love.window.setTitle('Breakout by RG')

	push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
		vsync = true, 
		resizable = true,
		fullscreen = false
	})

	-- load media

	gFonts = {
		['small'] = love.graphics.newFont('fonts/font.ttf', 8),
		['medium'] = love.graphics.newFont('fonts/font.ttf', 16),
		['large'] = love.graphics.newFont('fonts/font.ttf', 32)
	}

	gTextures = {
		['background'] = love.graphics.newImage('graphics/background.png'),
		['main'] = love.graphics.newImage('graphics/breakout.png')
	}

	gSounds = {
        ['paddle-hit'] = love.audio.newSource('sounds/paddle_hit.wav', 'static'),
        ['score'] = love.audio.newSource('sounds/score.wav', 'static'),
        ['wall-hit'] = love.audio.newSource('sounds/wall_hit.wav', 'static'),
        ['confirm'] = love.audio.newSource('sounds/confirm.wav', 'static'),
        ['select'] = love.audio.newSource('sounds/select.wav', 'static'),
        ['no-select'] = love.audio.newSource('sounds/no-select.wav', 'static'),
        ['brick-hit-1'] = love.audio.newSource('sounds/brick-hit-1.wav', 'static'),
        ['brick-hit-2'] = love.audio.newSource('sounds/brick-hit-2.wav', 'static'),
        ['hurt'] = love.audio.newSource('sounds/hurt.wav', 'static'),
        ['victory'] = love.audio.newSource('sounds/victory.wav', 'static'),
        ['recover'] = love.audio.newSource('sounds/recover.wav', 'static'),
        ['high-score'] = love.audio.newSource('sounds/high_score.wav', 'static'),
        ['pause'] = love.audio.newSource('sounds/pause.wav', 'static'),

        ['music'] = love.audio.newSource('sounds/music.wav', 'static')
    }

    -- load play objects
    background = PlacedImage(gTextures['background'], 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)

    gStateMachine = StateMachine({
    	['start'] = function() return StartState() end
    })

    gStateMachine:change('start')

end

function love.resize(w, h)
	push:resize(w, h)
end

function love.update(dt)
end

function love.keypressed(key) end

function love.draw() 
	push:start()

	background:render()
	gStateMachine:render()

	displayFPS()

	push:finish()
end

function displayFPS()
	love.graphics.setFont(gFonts['small'])
	love.graphics.setColor(0, 1, 0, 1)
	love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 5, 5)
end
