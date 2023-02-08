Ball = Class{}

function Ball:init(quad, width, height, x_start, y_start, x_speed, y_speed)
	self.quad = quad 
	self.width = width
	self.height = height
	self.x = x_start
	self.y = y_start 
	self.dx = x_speed
	self.dy = y_speed
end

function Ball:updatePosition(dt)
	self.x = self.x + self.dx * dt
	if self.x < 0 then
		self.x = self.x + self.width
		self.dx = - self.dx
		gSounds['wall-hit']:play()
	elseif (self.x + self.width) > VIRTUAL_WIDTH then
		self.x = self.x - self.width
		self.dx = - self.dx
		gSounds['wall-hit']:play()
	end
	self.y = self.y + self.dy * dt
	if self.y < 0 then
		self.y = self.y + self.height
		self.dy = - self.dy
		gSounds['wall-hit']:play()
	end
end

function Ball:collides(target)
	if self.x > (target.x + target.width) or (self.x + self.width) <target.x then
	    return false
	end
	if self.y > (target.y + target.height) or (self.y + self.height) <target.y then
	    return false
	end
	return true
end

function Ball:updatePositionCollides(target)
	if self.x < target.x then
		self.x = self.x - self.width
		self.dx = - self.dx
		gSounds['paddle-hit']:play()
	elseif self.x > (target.x + target.width) then
		self.x = self.x + self.width
		self.dx = - self.dx
		gSounds['paddel-hit']:play()
	elseif self.y < target.y then
		self.y = self.y - self.height
		self.dy = - self.dy
		gSounds['paddle-hit']:play()
	elseif self.y > (target.y + target.height) then
		self.y = self.y + self.height
		self.dy = - self.dy
		gSounds['paddel-hit']:play()
	end
end


function Ball:render()
	love.graphics.draw(gTextures['main'], self.quad, self.x, self.y)
end
