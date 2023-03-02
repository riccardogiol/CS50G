Tile = Class{}

function Tile:init(x, y, tileType, isTopper, tileSet, topperSet)
	self.x = x
    self.y = y
    self.width = TILE_SIZE
    self.height = TILE_SIZE

    self.tileType = tileType
    self.tileSet = tileSet
    self.isTopper = isTopper
    self.topperSet = topperSet
end

function Tile:collides()
	return self.tileType['COLL']
end

function Tile:render()
	love.graphics.draw(gTexture['tiles'], gTileQuads[self.tileSet][self.tileType['POS']], self.x, self.y)
	if self.isTopper then
		love.graphics.draw(gTexture['tile_tops'], gTopQuads[self.topperSet][1], self.x, self.y)
	end
end