Paddle = Class{}

function Paddle:init(image, x_start, y_start, speed)
	self.image = image 
	self.x = x_start
	self.y = y_start 
	self.speed = speed
	self.width = self.image:getWidth()
	self.height = self.image:getHeight()
end

function Paddle:update(dt, direction)
	if direction == 'right' then
		next_x = self.x + self.speed*dt
		self.x = math.min(next_x, VIRTUAL_WIDTH - self.width)
	else
		next_x = self.x - self.speed*dt
		self.x = math.max(next_x, 0)
	end
end

function Paddle:render()
	love.graphics.draw(self.image, self.x, self.y)
end
