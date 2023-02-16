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
	math.randomseed(os.time())

	rectList = {}

	for i = 1, 1000 do
		randY = math.random(0, VIRTUAL_HEIGHT - 10)
		randR = math.random(20, 255)
		randG = math.random(20, 255)
		randB = math.random(20, 255)
		randDuration = math.random(20, 100)

		local rect = {
			x = 0,
			y = randY,
			w = 10, 
			h = 10,
			r = randR/255,
			g = randG/255,
			b = randB/255, 
			a = 255
		}
		rectList[i] = rect
		Timer.tween(randDuration/10, {
			[rect] = {
				x = VIRTUAL_WIDTH - rect.w,
			}
		})
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
	push:start()
	for i, rect in pairs(rectList) do
		love.graphics.setColor(rect.r, rect.g, rect.b, rect.a)
		love.graphics.rectangle('line', rect.x, rect.y, rect.w, rect.h)
	end
	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.print("FPS " .. tostring(love.timer.getFPS()), 3, 3)
	push:finish()
end


