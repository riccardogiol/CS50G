Panel = Class{}

function Panel:init(x, y, width, height, color)
	self.x = x
	self.y = y
	self.width = width
	self.height = height

	self.color = color or {0, 0, 0.8, 0.8}

end

function Panel:render()
	love.graphics.setColor(self.color)
	love.graphics.rectangle('fill', self.x, self.y, self.width, self.height, 3)
	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.rectangle('line', self.x + 1, self.y + 1, self.width - 2, self.height - 2, 3)
end
