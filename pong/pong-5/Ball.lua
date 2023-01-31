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
	self.x = self.x + self.dx*dt
	next_y = self.y + self.dy*dt
	if next_y < playground.y_min then
		self.dy = - self.dy
		next_y = playground.y_min + (playground.y_min - next_y)
	elseif (next_y + self.height) > playground.y_max then
		self.dy = - self.dy
		next_y = playground.y_max - (next_y + self.height - playground.y_max) - self.height
	end
	self.y = next_y
end

function Ball:render()
	love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end