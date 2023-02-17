Tile = Class()

function Tile:init(quad, x, y, w, h)
	self.quad = quad
	self.x = x
	self.y = y
	self.w = w
	self.h = h
end

function Tile:render(offsetX, offsetY)
	love.graphics.draw(gTexture['tiles'], self.quad, self.x + offsetX, self.y + offsetY)
end