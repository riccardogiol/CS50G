push = require 'push'
Class = require 'class'
Timer = require 'knife.timer'

require 'tile'
require 'util'

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

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

	tileQuads = generateTileQuads(gTexture['tiles'], 32, 18, 6)

	board = generateBoard(tileQuads, 8, 8, 32, 4, 2)
end

function love.keypressed(key)
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
			board[j][i]:render(128, 16)
		end
	end

	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.print("FPS " .. tostring(love.timer.getFPS()), 3, 3)
	push:finish()
end


