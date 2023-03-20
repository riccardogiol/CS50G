Room = Class{}

function Room:init(x, y)
	self.width = MAP_WIDTH
    self.height = MAP_HEIGHT
    self.x = x or 0
    self.y = y or 0

    self.tiles = {}
    self:generateWallsAndFloors()

    self.doors = {}
    self:generateDoorways()

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

function Room:generateDoorways()
    self.doors['left'] = Doorway({
        x = self.x + MAP_RENDER_OFFSET_X,
        y = self.y + MAP_RENDER_OFFSET_Y + (MAP_HEIGHT / 2) * TILE_SIZE - TILE_SIZE,
        direction = 'left',
        open = 'true'
    })
    self.doors['right'] = Doorway({
        x = self.x + MAP_RENDER_OFFSET_X + (MAP_WIDTH * TILE_SIZE) - TILE_SIZE,
        y = self.y + MAP_RENDER_OFFSET_Y + (MAP_HEIGHT / 2) * TILE_SIZE - TILE_SIZE,
        direction = 'right',
        open = 'true'
    })
    self.doors['up'] = Doorway({
        x = self.x + MAP_RENDER_OFFSET_X + (MAP_WIDTH / 2 * TILE_SIZE) - TILE_SIZE,
        y = self.y + MAP_RENDER_OFFSET_Y,
        direction = 'up',
        open = 'true'
    })
    self.doors['down'] = Doorway({
        x = self.x + MAP_RENDER_OFFSET_X + (MAP_WIDTH / 2 * TILE_SIZE) - TILE_SIZE,
        y = self.y + MAP_RENDER_OFFSET_Y + (MAP_HEIGHT * TILE_SIZE) - TILE_SIZE,
        direction = 'down',
        open = 'true'
    })
end

function Room:render()
	for y = 1, self.height do
        for x = 1, self.width do
            love.graphics.draw(gTextures['tiles'], gFrames['tiles'][self.tiles[y][x].id],
                self.x + (x - 1) * TILE_SIZE + self.renderOffsetX, 
                self.y + (y - 1) * TILE_SIZE + self.renderOffsetY)
        end
    end

    for pos, door in pairs(self.doors) do
        door:render()
    end
end