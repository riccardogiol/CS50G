Tile = Class{}

function Tile:init(x, y, id)
	self.x = x
	self.y = y
	self.id = id
end

function Tile:render()
	if self.id == TILE_IDS['tall-grass'] then
		love.graphics.draw(gTextures['tiles'], gFrames['tiles'][46], self.x, self.y)
	end
	love.graphics.draw(gTextures['tiles'], gFrames['tiles'][self.id], self.x, self.y)
end