Paddle = Class{}

function Paddle:init(init_x, init_y, width, height, speed, y_min, y_max)
	self.x = init_x
	self.y = init_y
	self.width = width
	self.height = height
	self.speed = speed
	self.y_min = y_min
	self.y_max = y_max
end

function Paddle:updatePosition(dt, direction)
	if direction == 'up' then
		self.y = math.max(self.y - self.speed*dt, self.y_min)
	elseif direction == 'down' then
		self.y = math.min(self.y + self.speed*dt, self.y_max - self.height)
	end
end

function Paddle:render()
	love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end