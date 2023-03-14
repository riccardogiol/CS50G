Room = Class{}

function Room:init()
	self.width = MAP_WIDTH
    self.height = MAP_HEIGHT

    self.tiles = {}
    self:generateWallsAndFloors()

    self.renderOffsetX = MAP_RENDER_OFFSET_X
    self.renderOffsetY = MAP_RENDER_OFFSET_Y
end

function Room:generateWallsAndFloors()
	for y = 1, self.height do
		self.tiles[y] = {}
		for x = 1, self.width do
			self.tiles[y][x] = {
				id = TILE_FLOORS[math.random(#TILE_FLOORS)]
			}
		end
	end

    for x = 1, self.width do
    	self.tiles[1][x].id = TILE_TOP_WALLS[math.random(#TILE_TOP_WALLS)]
    	self.tiles[self.height][x].id = TILE_BOTTOM_WALLS[math.random(#TILE_BOTTOM_WALLS)]
    end

    for y = 1, self.height do
    	self.tiles[y][1].id = TILE_LEFT_WALLS[math.random(#TILE_LEFT_WALLS)]
    	self.tiles[y][self.width].id = TILE_RIGHT_WALLS[math.random(#TILE_RIGHT_WALLS)]
    end

    self.tiles[1][1].id = TILE_TOP_LEFT_CORNER
    self.tiles[1][self.width].id = TILE_TOP_RIGHT_CORNER
    self.tiles[self.height][1].id = TILE_BOTTOM_LEFT_CORNER
    self.tiles[self.height][self.width].id = TILE_BOTTOM_RIGHT_CORNER
end

function Room:render()
	for y = 1, self.height do
        for x = 1, self.width do
            love.graphics.draw(gTextures['tiles'], gFrames['tiles'][self.tiles[y][x].id],
                (x - 1) * TILE_SIZE + self.renderOffsetX, 
                (y - 1) * TILE_SIZE + self.renderOffsetY)
        end
    end
end