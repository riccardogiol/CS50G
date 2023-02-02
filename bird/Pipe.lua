Pipe = Class{}

function Pipe:init(image, x, y, speed)
	self.image = image
	self.x = x 
	self.y = y 
	self.speed = speed
end

function Pipe:updatePosition(dt)
	self.x = self.x - self.speed*dt
end

function Pipe:isOutL()
	if (self.x + self.image:getWidth()) < 0 then
		return true
	end
	return false
end

function Pipe:render()
	love.graphics.draw(self.image, self.x, self.y)
end