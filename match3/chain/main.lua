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

	rect = {
		x = 0,
		y = 0,
		w = 20,
		h = 10
	}

	movementDuration = 5

	Timer.tween(movementDuration, {
		[rect] = {
			x = VIRTUAL_WIDTH - rect.w,
		}
	}):finish(function()
		Timer.tween(movementDuration, {
			[rect] = {
				y = VIRTUAL_HEIGHT - rect.h
			}
		}):finish(function()
			Timer.tween(movementDuration, {
				[rect] = {
					x = 0
				}
			}):finish(function()
				Timer.tween(movementDuration, {
					[rect] = {
						y = 0
					}
				})
			end)
		end)
	end)

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

	love.graphics.setColor(1, 0.5, 1, 1)
	love.graphics.rectangle('line', rect.x, rect.y, rect.w, rect.h)
	
	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.print("FPS " .. tostring(love.timer.getFPS()), 3, 3)
	push:finish()
end


