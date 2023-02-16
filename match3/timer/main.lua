push = require 'push'
Timer = require 'knife.timer'

VIRTUAL_WIDTH = 384
VIRTUAL_HEIGHT = 216

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

function love.load()
	love.graphics.setDefaultFilter('nearest', 'nearest')
	push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
		fullscreen = false, 
		vsync = true, 
		resizable = false
	})

	intervals = {1, 2, 5, 8, 3}

	counters = {0, 0, 0, 0, 0}

	for i, c in pairs(counters) do
		Timer.every(intervals[i], function()
			counters[i] = counters[i] + 1
		end)
	end
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
	for i, c in pairs(counters) do
		love.graphics.print("Timer " .. tostring(i) .. ": " .. tostring(c), VIRTUAL_WIDTH/3, VIRTUAL_HEIGHT/4 + i*16)
	end
end


