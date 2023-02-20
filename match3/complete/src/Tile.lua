Tile = Class()

function Tile:init(quad, color, x, y, w, h)
	self.quad = quad
	self.x = x
	self.y = y
	self.w = w
	self.h = h
	self.color = color
end

function Tile:getPosition()
	return self.x, self.y
end

function Tile:setPosition(x, y)
	self.x, self.y = x, y
end

function Tile:render(offsetX, offsetY)
	love.graphics.draw(gTexture['tiles'], self.quad, self.x + offsetX, self.y + offsetY)
end