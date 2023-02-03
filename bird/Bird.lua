Bird = Class{}

function Bird:init(path, x, y, acceleration, rebounce)
	self.image = love.graphics.newImage(path)
	self.x = x - self.image:getWidth()/2
	self.y = y - self.image:getHeight()/2
	self.acceleration = acceleration
	self.rebounce = rebounce
	self.speed = 0
	self.width = self.image:getWidth()
	self.height = self.image:getHeight()
end

function Bird:updatePosition(dt)
	if love.keyboard.wasPressed('space') then
		self.speed = - self.rebounce
	end

	self.speed = self.speed + self.acceleration * dt
	self.y = self.y + self.speed * dt 
end

function Bird:collidesBorder(y_min, y_max)
	if self.y < y_min or (self.y + self.height) > y_max then
		return true
	end
	return false
end

function Bird:collides(pipes_pair)
	if self:collidesPipe(pipes_pair.pipe_bottom) then
		return true
	elseif self:collidesPipe(pipes_pair.pipe_top) then
		return true
	end
	return false
end

function Bird:collidesPipe(pipe)
	if self.x + 4 > (pipe.x + pipe.width) or (self.x + self.width) - 4 < pipe.x then
		return false
	end

	if self.y + 4 > (pipe.y + pipe.height) or (self.y + self.height) - 4 < pipe.y then
		return false
	end

	return true
end

function Bird:render()
	love.graphics.draw(self.image, self.x, self.y)
end