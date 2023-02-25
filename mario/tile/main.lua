push = require 'push'
require 'util'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 256
VIRTUAL_HEIGHT = 144

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
		['brick'] = love.graphics.newImage('tiles.png')
	}

	quads = generateQuads(gTexture['brick'], TILE_SIZE, TILE_SIZE)

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

	characterX = 0

end

function love.resize(w, h)
	push:resize(w,h)
end

function love.update(dt)
	if love.keyboard.isDown('left') then
		characterX = characterX - CHARACTER_SPEED * dt
	elseif love.keyboard.isDown('right') then
		characterX = characterX + CHARACTER_SPEED * dt
	end


end

function love.keypressed(key)
	if key == 'escape' then
		love.event.quit()
	end
end

function love.draw()
	push:start()

	love.graphics.translate(-math.floor(characterX), 0)

	for y = 1, mapHeight do
		for x = 1 , mapWidth do
			love.graphics.draw(gTexture['brick'], quads[tiles[y][x]], (x-1) * TILE_SIZE, (y-1) * TILE_SIZE)
		end
	end

	push:finish()
end
