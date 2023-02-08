Paddle = Class{}

function Paddle:init(quad, width, height, x_start, y_start, speed)
	self.quad = quad 
	self.width = width
	self.height = height
	self.x = x_start
	self.y = y_start 
	self.speed = speed
end

function Paddle:updatePosition(dt, direction)
	if direction == 'right' then
		next_x = self.x + self.speed*dt
		self.x = math.min(next_x, VIRTUAL_WIDTH - self.width)
	else
		next_x = self.x - self.speed*dt
		self.x = math.max(next_x, 0)
	end
end

function Paddle:render()
	love.graphics.draw(gTextures['main'], self.quad, self.x, self.y)
end
