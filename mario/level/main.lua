push = require 'push'
Class = require 'class'

require 'util'
require 'Animation'

WINDOW_WIDTH = 640
WINDOW_HEIGHT = 360

VIRTUAL_WIDTH = 256
VIRTUAL_HEIGHT = 144

CHARACTER_WIDTH = 16
CHARACTER_HEIGHT = 20
CHARACTER_SPEED = 60
CHARACTER_JUMP = -200
GRAVITY = 420

TILE_SIZE = 16

SKY = 5
GROUND = 3

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
		['brick'] = love.graphics.newImage('tiles.png'),
		['character'] = love.graphics.newImage('character.png'),
		['tiles'] = love.graphics.newImage('tiles.png'),
		['tile_tops'] = love.graphics.newImage('tile_tops.png')
	}

	-- prepare map

	backgroundColor = {math.random(), math.random(), math.random(), 1}

	brickQuads = generateQuads(gTexture['brick'], TILE_SIZE, TILE_SIZE)
	characterQuads = generateQuads(gTexture['character'], CHARACTER_WIDTH, CHARACTER_HEIGHT)
	
	tileGroupRows = 10
	tileGroupColumns = 6
	topGroupRows = 18
	topGroupColumns = 6
	rowsPerGroup = 4
	colsPerGroup = 5
	tilesRawQuads = generateQuads(gTexture['tiles'], TILE_SIZE, TILE_SIZE)
	tileSets = generateQuadsGroups(tilesRawQuads, tileGroupRows, tileGroupColumns, rowsPerGroup, colsPerGroup)

	topRawQuads = generateQuads(gTexture['tile_tops'], TILE_SIZE, TILE_SIZE)
	topSets = generateQuadsGroups(topRawQuads, topGroupRows, topGroupColumns, rowsPerGroup, colsPerGroup)

	mapHeight = 20
	mapWidth = 20

	tiles = {}

	for r = 1, mapHeight do
		newRow = {}
		for c = 1, mapWidth do
			newRow[c] = {
				id = r < 6 and SKY or GROUND,
				top = r == 6
			}
		end
		tiles[r] = newRow
	end

	tileGroup = math.random(#tileSets)
	topGroup = math.random(#topSets)

	-- prepare character

	characterX = VIRTUAL_WIDTH/2 - CHARACTER_WIDTH/2
	characterY = 5 * TILE_SIZE - CHARACTER_HEIGHT
	characterDY = CHARACTER_JUMP
	characterDirection = 'right'

	idleAnimation = Animation({
		frames = {1},
		interval = 1
	})

	movingAnimation = Animation({
		frames = {10, 11},
		interval = 0.2
	})

	jumpingAnimation = Animation({
		frames = {3},
		interval = 1
	})

	currentCharacterState = 'standing'
	currentCharacterAnimation = idleAnimation

	cameraScrollX = 0

	love.keyboard.keypressed = {}

end

function love.resize(w, h)
	push:resize(w,h)
end

function love.update(dt)
	if love.keyboard.keypressed['r'] then
		backgroundColor = {math.random(), math.random(), math.random(), 1}
		tileGroup = math.random(#tileSets)
		topGroup = math.random(#topSets)
	end
	if love.keyboard.keypressed['space'] and currentCharacterState == 'standing' then
		currentCharacterState = 'jumping'
		characterDY = CHARACTER_JUMP
	end

	if love.keyboard.isDown('left') then
		characterX = characterX - CHARACTER_SPEED * dt
		characterDirection = 'left'
		currentCharacterAnimation = movingAnimation
	elseif love.keyboard.isDown('right') then
		characterX = characterX + CHARACTER_SPEED * dt
		characterDirection = 'right'
		currentCharacterAnimation = movingAnimation
	else
		currentCharacterAnimation = idleAnimation
	end

	if not (currentCharacterState == 'standing') then
		currentCharacterAnimation = jumpingAnimation
		characterDY = characterDY + GRAVITY * dt
		characterY = characterY + characterDY * dt
		if characterDY > 0 then
			if characterY > 5*TILE_SIZE - CHARACTER_HEIGHT then
				characterY = 5*TILE_SIZE - CHARACTER_HEIGHT
				characterDY = 0
				currentCharacterState = 'standing'
			else
				currentCharacterState = 'falling'
			end
		end
	end

	cameraScrollX = - (characterX - (VIRTUAL_WIDTH/2 - CHARACTER_WIDTH/2))

	currentCharacterAnimation:update(dt)

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


	love.graphics.translate(math.floor(cameraScrollX), 0)

	love.graphics.clear(backgroundColor)

	for y = 1, mapHeight do
		for x = 1 , mapWidth do
			love.graphics.draw(gTexture['tiles'], tileSets[tileGroup][tiles[y][x].id],
				(x-1) * TILE_SIZE, (y-1) * TILE_SIZE)
			if tiles[y][x].top then
				love.graphics.draw(gTexture['tile_tops'], topSets[topGroup][1],
					(x-1) * TILE_SIZE, (y-1) * TILE_SIZE)
			end
		end
	end


	xMirroring = characterDirection == 'right' and 1 or -1

	love.graphics.draw(gTexture['character'], characterQuads[currentCharacterAnimation:getCurrentFrame()],
		math.floor(characterX) + CHARACTER_WIDTH/2, math.floor(characterY) + CHARACTER_HEIGHT/2, 
		0, xMirroring, 1,
		CHARACTER_WIDTH/2, CHARACTER_HEIGHT/2)


	love.graphics.translate( - math.floor(cameraScrollX), 0)


	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.print(tostring(currentCharacterState), 2, 30)

	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.print('FPS ' .. tostring(love.timer.getFPS()), 2, 2)

	push:finish()
end
