push = require 'push'
Class = require 'class'

require 'util'
require 'Animation'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 256
VIRTUAL_HEIGHT = 144

CHARACTER_WIDTH = 16
CHARACTER_HEIGHT = 20
CHARACTER_SPEED = 40

TILE_SIZE = 16

SKY = 2
GROUND = 1

function love.load()
	love.graphics.setDefaultFilter('nearest', 'nearest')
	push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
		fullscreen = false, 
		vsync = true, 
		resizable = true
	})

	gTexture = {
		['brick'] = love.graphics.newImage('tiles.png'),
		['character'] = love.graphics.newImage('character.png')
	}

	-- prepare map

	brickQuads = generateQuads(gTexture['brick'], TILE_SIZE, TILE_SIZE)
	characterQuads = generateQuads(gTexture['character'], CHARACTER_WIDTH, CHARACTER_HEIGHT)

	mapHeight = 20
	mapWidth = 20

	tiles = {}

	for r = 1, mapHeight do
		newRow = {}
		for c = 1, mapWidth do
			newRow[c] = r < 6 and SKY or GROUND
		end
		tiles[r] = newRow
	end

	-- prepare character

	characterX = VIRTUAL_WIDTH/2 - CHARACTER_WIDTH/2
	characterY = 5 * TILE_SIZE - CHARACTER_HEIGHT
	characterDirection = 'right'

	idleAnimation = Animation({
		frames = {1},
		interval = 1
	})

	movingAnimation = Animation({
		frames = {10, 11},
		interval = 0.2
	})

	currentCharacterAnimation = idleAnimation

	cameraScrollX = 0

end

function love.resize(w, h)
	push:resize(w,h)
end

function love.update(dt)
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

	cameraScrollX = - (characterX - (VIRTUAL_WIDTH/2 - CHARACTER_WIDTH/2))

	currentCharacterAnimation:update(dt)

end

function love.keypressed(key)
	if key == 'escape' then
		love.event.quit()
	end
end

function love.draw()
	push:start()


	love.graphics.translate(math.floor(cameraScrollX), 0)

	for y = 1, mapHeight do
		for x = 1 , mapWidth do
			love.graphics.draw(gTexture['brick'], brickQuads[tiles[y][x]], (x-1) * TILE_SIZE, (y-1) * TILE_SIZE)
		end
	end

	xMirroring = characterDirection == 'right' and 1 or -1

	love.graphics.draw(gTexture['character'], characterQuads[currentCharacterAnimation:getCurrentFrame()],
		math.floor(characterX) + CHARACTER_WIDTH/2, math.floor(characterY) + CHARACTER_HEIGHT/2, 
		0, xMirroring, 1,
		CHARACTER_WIDTH/2, CHARACTER_HEIGHT/2)

	push:finish()
end
