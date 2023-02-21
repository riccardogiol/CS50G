Tile = Class()

function Tile:init(quad, color, x, y, w, h)
	self.quad = quad
	self.x = x
	self.y = y
	self.w = w
	self.h = h
	self.color = color
end


function Tile:render(offsetX, offsetY)
	love.graphics.draw(gTexture['tiles'], self.quad, self.x + offsetX, self.y + offsetY)
end