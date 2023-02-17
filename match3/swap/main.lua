push = require 'push'
Class = require 'class'
Timer = require 'knife.timer'

require 'tile'
require 'util'

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

	gTexture = {
		['tiles'] = love.graphics.newImage('match3.png')
	}

	tileQuads = generateTileQuads(gTexture['tiles'], TILE_SIZE, 18, 6)

	board = generateBoard(tileQuads, NUM_ROW, NUM_COL, TILE_SIZE, 4, 2)

	selector = {
		row = 0,
		col = 0,
		dim = TILE_SIZE,
		blocked = false
	}
	selectedTile = {
		row = 0,
		col = 0,
		selected = false
	}
	--love.keyboard.keypressed = {}
end

function love.keypressed(key)

	if not selector.blocked then
		if key == 'enter' or key == 'return' then
			if not selectedTile.selected then
				selectedTile.row = selector.row
				selectedTile.col = selector.col
				selectedTile.selected = true
			else
				tweenTiles(selectedTile.row, selectedTile.col, selector.row, selector.col)
				selectedTile.selected = false
			end
		end

		if key == 'right' then
			if selectedTile.selected then
				selector.col = math.min(selector.col + 1, selectedTile.col + 1, NUM_COL - 1)
				selector.row = selectedTile.row
			else
				selector.col = math.min(selector.col + 1, NUM_COL - 1)
			end
		elseif key == 'left' then
			if selectedTile.selected then
				selector.col = math.max(selector.col - 1, selectedTile.col - 1, 0)
				selector.row = selectedTile.row
			else
				selector.col = math.max(selector.col - 1, 0)
			end
		elseif key == 'up' then
			if selectedTile.selected then
				selector.row = math.max(selector.row - 1, selectedTile.row - 1, 0)
				selector.col = selectedTile.col
			else
				selector.row = math.max(selector.row - 1, 0)
			end
		elseif key == 'down' then
			if selectedTile.selected then
				selector.row = math.min(selector.row + 1, selectedTile.row + 1, NUM_ROW - 1)
				selector.col = selectedTile.col
			else
				selector.row = math.min(selector.row + 1, NUM_ROW - 1)
			end
		end
	end

    if key == 'escape' then
        love.event.quit()
    end
end

function love.update(dt)
	Timer.update(dt)
end

function love.draw()
	push:start()
	
	love.graphics.setColor(1, 1, 1, 1)
	for j=0,7 do
		for i=0,7 do
			board[j][i]:render(OFFSET_X, OFFSET_Y)
		end
	end

	love.graphics.setColor(1, 0, 0, 1)
	local selectorX, selectorY = board[selector.row][selector.col]:getPosition()
	love.graphics.rectangle('line', OFFSET_X + selectorX, OFFSET_Y + selectorY, selector.dim, selector.dim)

	if selectedTile.selected then
		local selectedX, selectedY = board[selectedTile.row][selectedTile.col]:getPosition()
		love.graphics.setColor(1, 1, 1, 0.3)
		love.graphics.rectangle('fill', OFFSET_X + selectedX, OFFSET_Y + selectedY, TILE_SIZE, TILE_SIZE)
	end

	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.print("FPS " .. tostring(love.timer.getFPS()), 3, 3)
	push:finish()
end


