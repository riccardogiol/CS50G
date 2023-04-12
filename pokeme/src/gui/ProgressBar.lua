ProgressBar = Class{}

function ProgressBar:init(def)
	self.x = def.x
	self.y = def.y
	self.width = def.width
	self.height = def.height

	self.color = def.color

	self.maxValue = def.maxValue
	self.currentValue = def.currentValue or def.maxValue
end

function ProgressBar:render()
	love.graphics.setColor(0, 0, 0, 1)
	love.graphics.rectangle('line', self.x - 1, self.y - 1, self.width + 2, self.height + 2, 1)
	local currentPixels = (self.currentValue / self.maxValue) * self.width
	love.graphics.setColor(self.color)
	love.graphics.rectangle('fill', self.x, self.y, currentPixels, self.height, 1)
end