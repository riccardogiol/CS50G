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
		['tiles'] = love.graphics.newImage('media/match3.png')
	}

	gTileQuads = generateTileQuads(gTexture['tiles'], TILE_SIZE, 18, 6)

	gLevelMaker = LevelMaker()

	gStateMachine = StateMachine({
		['PlayState'] = function() return PlayState() end
	})

	gStateMachine:change('PlayState', {
		board = gLevelMaker:generateBoard(tileQuads, NUM_ROW, NUM_COL, TILE_SIZE, 4, 2)
	})
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

	gStateMachine:render()

	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.print("FPS " .. tostring(love.timer.getFPS()), 3, 3)
	push:finish()
end


