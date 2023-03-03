require 'src/Dependencies'

function love.load()
	love.graphics.setDefaultFilter('nearest', 'nearest')
	push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
		fullscreen = false, 
		vsync = true, 
		resizable = true
	})

	math.randomseed(os.time())

	--load media

	gTexture = {
		['brick'] = love.graphics.newImage('media/images/tiles.png'),
		['character'] = love.graphics.newImage('media/images/character.png'),
		['snail'] = love.graphics.newImage('media/images/creatures.png'),
		['tiles'] = love.graphics.newImage('media/images/tiles.png'),
		['tile_tops'] = love.graphics.newImage('media/images/tile_tops.png')
	}

	tilesRawQuads = generateQuads(gTexture['tiles'], TILE_SIZE, TILE_SIZE)
	topRawQuads = generateQuads(gTexture['tile_tops'], TILE_SIZE, TILE_SIZE)

	local tileGroupRows = 10
	local tileGroupColumns = 6
	local topGroupRows = 18
	local topGroupColumns = 6
	local rowsPerGroup = 4
	local colsPerGroup = 5

	gTileQuads = generateQuadsGroups(tilesRawQuads, tileGroupRows, tileGroupColumns, rowsPerGroup, colsPerGroup)
	gTopQuads = generateQuadsGroups(topRawQuads, topGroupRows, topGroupColumns, rowsPerGroup, colsPerGroup)

	
	gFrames = {
		['character'] = generateQuads(gTexture['character'], CHARACTER_WIDTH, CHARACTER_HEIGHT),
		['snail'] = generateQuads(gTexture['snail'], TILE_SIZE, TILE_SIZE)
	}

	-- prepare game states

	gStateMachine = StateMachine ({
		['play'] = function() return PlayState() end
	})

	gStateMachine:change('play')

	love.keyboard.keypressed = {}

end

function love.resize(w, h)
	push:resize(w,h)
end

function love.update(dt)
	gStateMachine:update(dt)
	love.keyboard.keypressed = {}
end

function love.keypressed(key)
	love.keyboard.keypressed[key] = true
	if key == 'escape' then
		love.event.quit()
	end
end

function love.draw()
	push:start()

	gStateMachine:render()

	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.print('FPS ' .. tostring(love.timer.getFPS()), 2, 2)

	push:finish()
end
