GroundImage = Class{}

function GroundImage:init(path, speed, pixel_period, x, y)
	self.image = love.graphics.newImage(path)
	self.speed = speed 
	self.pixel_period = pixel_period
	self.x = x
	self.y = y
end

function GroundImage:updatePosition(dt)
	self.x = (self.x + self.speed*dt) % self.pixel_period
end


function GroundImage:render()
	love.graphics.draw(self.image, - self.x, self.y)
end