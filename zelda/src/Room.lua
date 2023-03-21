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

    self.objects = {}
    self:generateObjects()

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
        open = false
    })
    self.doors['right'] = Doorway({
        x = self.x + MAP_RENDER_OFFSET_X + (MAP_WIDTH * TILE_SIZE) - TILE_SIZE,
        y = self.y + MAP_RENDER_OFFSET_Y + (MAP_HEIGHT / 2) * TILE_SIZE - TILE_SIZE,
        direction = 'right',
        open = false
    })
    self.doors['up'] = Doorway({
        x = self.x + MAP_RENDER_OFFSET_X + (MAP_WIDTH / 2 * TILE_SIZE) - TILE_SIZE,
        y = self.y + MAP_RENDER_OFFSET_Y,
        direction = 'up',
        open = false
    })
    self.doors['down'] = Doorway({
        x = self.x + MAP_RENDER_OFFSET_X + (MAP_WIDTH / 2 * TILE_SIZE) - TILE_SIZE,
        y = self.y + MAP_RENDER_OFFSET_Y + (MAP_HEIGHT * TILE_SIZE) - TILE_SIZE,
        direction = 'down',
        open = false
    })
end

function Room:generateObjects()
    local switch = Object(
        GAME_OBJECT_DEFS['switch'],
        math.random(MAP_RENDER_OFFSET_X + TILE_SIZE, VIRTUAL_WIDTH - TILE_SIZE * 2 - 16),
        math.random(MAP_RENDER_OFFSET_Y + TILE_SIZE, VIRTUAL_HEIGHT - (VIRTUAL_HEIGHT - MAP_HEIGHT * TILE_SIZE) + MAP_RENDER_OFFSET_Y - TILE_SIZE - 16),
        self.x,
        self.y
    )

    switch.onCollide = function()
        if switch.state == 'unpressed' then
            switch.state = 'pressed'
            for k, door in pairs(self.doors) do
                door.open = true
            end
        end
    end
    table.insert(self.objects, switch)
end

function Room:refreshObjectsPosition()
    for i, obj in pairs(self.objects) do
        obj.offsetX = self.x
        obj.offsetY = self.y
    end
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

    for i, obj in pairs(self.objects) do
        obj:render()
    end
end