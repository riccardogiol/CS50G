require 'src/dependencies'

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

OFFSET_X = 128
OFFSET_Y = 16

NUM_COL = 8
NUM_ROW = 8

TILE_SIZE = 32

function love.load()
	love.graphics.setDefaultFilter('nearest', 'nearest')
	
	push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
		fullscreen = false, 
		vsync = true, 
		resizable = false
	})
	math.randomseed(os.time())

	love.keyboard.keyPressed = {}

	gTexture = {
		['tiles'] = love.graphics.newImage('media/match3.png'),
		['background'] = love.graphics.newImage('media/background.png')
	}

	gFonts = {
		['small'] = love.graphics.newFont('media/font.ttf', 8),
		['medium'] = love.graphics.newFont('media/font.ttf', 16),
		['large'] = love.graphics.newFont('media/font.ttf', 32)
	}

	gSounds = {
		['select'] = love.audio.newSource('media/select.wav', 'static'),
		['remove'] = love.audio.newSource('media/remove_blocks.wav', 'static'),
		['fall'] = love.audio.newSource('media/falling_block.wav', 'static')
	}

	gSounds['remove']:setVolume(0.5)

	gTileQuads = generateTileQuads(gTexture['tiles'], TILE_SIZE, 18, 6)

	gLevelMaker = LevelMaker()

	gStateMachine = StateMachine({
		['StartState'] = function() return StartState() end,
		['TransitionState'] = function() return TransitionState() end,
		['PlayState'] = function() return PlayState() end
	})

	backgroundX = -52
	timerBack = Timer.every(0.05, function()
		backgroundX = ((backgroundX - 1) % 52) - 52
	end)

	colors = gLevelMaker:generateColors(4)

	gStateMachine:change('StartState')
end

function love.keypressed(key)
	love.keyboard.keyPressed[key] = true
end

function love.keyboard.wasPressed(key)
	if love.keyboard.keyPressed[key] then
		return true
	end
	return false
end

function love.update(dt)
	Timer.update(dt)
	gStateMachine:update(dt)
	love.keyboard.keyPressed = {}
end

function love.draw()
	push:start()

	love.graphics.draw(gTexture['background'], backgroundX, 0)

	gStateMachine:render()

	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.setFont(gFonts['small'])
	love.graphics.print("FPS " .. tostring(love.timer.getFPS()), 3, 3)
	push:finish()
end


