Level = Class{}

function Level:init()
	self.tileMap = TileMap(24, 14)
	self.tileMap:randomizeMap()
end

function Level:update(dt)
	end

function Level:render()
	self.tileMap:render()
end
