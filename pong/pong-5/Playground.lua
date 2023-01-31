Playground = Class{}

function Playground:init(x_min, x_max, y_min, y_max, thick)
	self.x_min = x_min
	self.x_max = x_max
	self.y_min = y_min
	self.y_max = y_max
	self.thick = thick
end

function Playground:render()
	love.graphics.rectangle('fill', self.x_min, self.y_min - self.thick, self.x_max-self.x_min, self.thick)
	love.graphics.rectangle('fill', self.x_min, self.y_max, self.x_max-self.x_min, self.thick)
end