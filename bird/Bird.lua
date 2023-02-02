Bird = Class{}

function Bird:init(path, x, y, acceleration, rebounce)
	self.image = love.graphics.newImage(path)
	self.x = x - self.image:getWidth()/2
	self.y = y - self.image:getHeight()/2
	self.acceleration = acceleration
	self.rebounce = rebounce
	self.speed = 0
end

function Bird:updatePosition(dt)
	if love.keyboard.wasPressed('space') then
		self.speed = - self.rebounce
	end
	
	self.speed = self.speed + self.acceleration * dt
	self.y = self.y + self.speed * dt 
end

function Bird:render()
	love.graphics.draw(self.image, self.x, self.y)
	love.graphics.print(tostring(self.speed), 0, 0)
end