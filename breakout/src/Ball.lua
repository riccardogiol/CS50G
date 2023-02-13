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
		self.x = - self.x 
		self.dx = - self.dx
		gSounds['wall-hit']:play()
	elseif (self.x + self.width) > VIRTUAL_WIDTH then
		self.x = 2 * VIRTUAL_WIDTH - self.x  - 2 * self.width
		self.dx = - self.dx
		gSounds['wall-hit']:play()
	end
	self.y = self.y + self.dy * dt
	if self.y < 0 then
		self.y = - self.y
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
	if self.x < target.x and self.dx > 0 then
		self.x = 2 * target.x - self.x - 2 * self.width
		self.dx = - self.dx
		gSounds['paddle-hit']:play()
	elseif (((self.x + self.width) > (target.x + target.width)) and self.dx < 0) then
		self.x = 2 * target.x + 2 * target.width - self.x
		self.dx = - self.dx
		gSounds['paddle-hit']:play()
	elseif self.y < target.y and self.dy > 0 then
		self.y = 2 * target.y - 2 * self.height - self.y
		self.dy = - self.dy
		gSounds['paddle-hit']:play()
	else
		self.y = 2 * target.y + target.width - self.y
		self.dy = - self.dy
		gSounds['paddle-hit']:play()
	end
end

function Ball:updateSpeedPaddleCollision(paddle)
	if (self.x + (self.width/2) < paddle.x + (paddle.width/2)) and self.dx > 0 then
		self.dx = self.dx - 20 - (12 * (paddle.x + paddle.width/2 - self.x))
	elseif (self.x > paddle.x + (paddle.width/2)) and self.dx < 0 then
		self.dx = self.dx + 20 + (12 * (self.x - paddle.x - paddle.width/2))
	end
	self.dx = self.dx + (math.random(-5, 5) * 2)
end


function Ball:render()
	love.graphics.draw(gTextures['main'], self.quad, self.x, self.y)
end
