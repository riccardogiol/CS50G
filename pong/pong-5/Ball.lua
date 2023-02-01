Ball = Class{}

function Ball:init(init_x, init_y, width, height, dx_init, dy_init)
	self.x = init_x
	self.y = init_y
	self.width = width
	self.height = height
	self.dx = dx_init
	self.dy = dy_init
end

function Ball:setPosition(x, y)
	self.x = x
	self.y = y
end

function Ball:setSpeed(dx, dy)
	self.dx = dx
	self.dy = dy
end

function Ball:updatePosition(dt, paddle1, paddle2, playground)
	--udate position for Y, checking playground
	next_y = self.y + self.dy*dt
	if next_y < playground.y_min then
		self.dy = - self.dy
		next_y = playground.y_min + (playground.y_min - next_y)
	elseif (next_y + self.height) > playground.y_max then
		self.dy = - self.dy
		next_y = playground.y_max - (next_y + self.height - playground.y_max) - self.height
	end
	self.y = next_y

	--udate position for X, checking paddles
	self.x = self.x + self.dx*dt

	if self:collides(paddle1) then
		self.dx = - self.dx * 1.05
		self.x = (paddle1.x + paddle1.width) + ((paddle1.x + paddle1.width) - self.x)
		self.dy = (self.dy / math.abs(self.dy)) * (math.random(1, 50) * 1.5)
	elseif self:collides(paddle2) then
		self.dx = - self.dx * 1.05
		self.x = paddle2.x - ((self.x + self.width) - paddle2.x)
		self.dy = (self.dy / math.abs(self.dy)) * (math.random(1, 50) * 1.5)
	end 
end

function Ball:collides(paddle)
	if self.x > (paddle.x + paddle.width) or (self.x + self.width) < paddle.x then
		return false
	end

	if self.y > (paddle.y + paddle.height) or (self.y + self.height) < paddle.y then
		return false
	end

	return true
end

function Ball:outL(playground)
	if self.x < playground.x_min then
		return true
	end
	return false
end

function Ball:outR(playground)
	if (self.x + self.width) > playground.x_max then
		return true
	end
	return false
end

function Ball:render()
	love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end