Dungeon = Class{}

function Dungeon:init(player)
	self.currentRoom = Room()
	self.player = player

    self.nextRoom = nil
    self.cameraX = 0
    self.cameraY = 0
    self.shifting = false


    Event.on('shift-left', function()
        self:beginShifting(-VIRTUAL_WIDTH, 0)
    end)

    Event.on('shift-right', function()
        self:beginShifting(VIRTUAL_WIDTH, 0)
    end)

    Event.on('shift-up', function()
        self:beginShifting(0, -VIRTUAL_HEIGHT)
    end)

    Event.on('shift-down', function()
        self:beginShifting(0, VIRTUAL_HEIGHT)
    end)
end


function Dungeon:beginShifting(shiftX, shiftY)
    self.shifting = true
    self.nextRoom = Room(shiftX, shiftY)

    local nextPlayerX, nextPlayerY = self.player.x, self.player.y
    if shiftX > 0 then
        nextPlayerX = VIRTUAL_WIDTH + (MAP_RENDER_OFFSET_X + TILE_SIZE)
        self.nextRoom.doors['left'].open = true
    elseif shiftX < 0 then
        nextPlayerX = -VIRTUAL_WIDTH + (MAP_RENDER_OFFSET_X + (MAP_WIDTH * TILE_SIZE) - TILE_SIZE - self.player.width)
        self.nextRoom.doors['right'].open = true
    elseif shiftY > 0 then
        nextPlayerY = VIRTUAL_HEIGHT + (MAP_RENDER_OFFSET_Y + self.player.height / 2)
        self.nextRoom.doors['up'].open = true
    else
        nextPlayerY = -VIRTUAL_HEIGHT + MAP_RENDER_OFFSET_Y + (MAP_HEIGHT * TILE_SIZE) - TILE_SIZE - self.player.height
        self.nextRoom.doors['down'].open = true
    end

    Timer.tween(1, {
        [self] = {cameraX = shiftX, cameraY = shiftY},
        [self.player] = {x = nextPlayerX, y = nextPlayerY}
    }):finish(function()
        self:finishShifting()
        if shiftX < 0 then
            self.player.x = MAP_RENDER_OFFSET_X + (MAP_WIDTH * TILE_SIZE) - TILE_SIZE - self.player.width
        elseif shiftX > 0 then
            self.player.x = MAP_RENDER_OFFSET_X + TILE_SIZE
        elseif shiftY < 0 then
            self.player.y = MAP_RENDER_OFFSET_Y + (MAP_HEIGHT * TILE_SIZE) - TILE_SIZE - self.player.height
        else
            self.player.y = MAP_RENDER_OFFSET_Y + self.player.height / 2
        end
    end)
end

function Dungeon:finishShifting()
    self.cameraX = 0
    self.cameraY = 0
    self.shifting = false

    self.currentRoom = self.nextRoom
    self.currentRoom.x = 0
    self.currentRoom.y = 0 
    self.currentRoom:generateDoorways()
    self.currentRoom:refreshObjectsPosition()
    self.nextRoom = nil
end

function Dungeon:update(dt)
	if not self.shifting then
		self.player:update(dt)
	end

	for k, obj in pairs(self.currentRoom.objects) do
        if self.player:collides(obj) then
            obj:onCollide()
        end
    end
end

function Dungeon:render()
	if self.shifting then
        love.graphics.translate(-math.floor(self.cameraX), -math.floor(self.cameraY))
    end

	self.currentRoom:render()
    if self.nextRoom then
        self.nextRoom:render()
    end

    love.graphics.stencil(function()
        
        -- left
        love.graphics.rectangle('fill', -TILE_SIZE - 6, MAP_RENDER_OFFSET_Y + (MAP_HEIGHT / 2) * TILE_SIZE - TILE_SIZE,
            TILE_SIZE * 2 + 6, TILE_SIZE * 2)
        
        -- right
        love.graphics.rectangle('fill', MAP_RENDER_OFFSET_X + (MAP_WIDTH * TILE_SIZE),
            MAP_RENDER_OFFSET_Y + (MAP_HEIGHT / 2) * TILE_SIZE - TILE_SIZE, TILE_SIZE * 2 + 6, TILE_SIZE * 2)
        
        -- top
        love.graphics.rectangle('fill', MAP_RENDER_OFFSET_X + (MAP_WIDTH / 2) * TILE_SIZE - TILE_SIZE,
            -TILE_SIZE - 6, TILE_SIZE * 2, TILE_SIZE * 2 + 12)
        
        --bottom
        love.graphics.rectangle('fill', MAP_RENDER_OFFSET_X + (MAP_WIDTH / 2) * TILE_SIZE - TILE_SIZE,
            VIRTUAL_HEIGHT - TILE_SIZE - 6, TILE_SIZE * 2, TILE_SIZE * 2 + 12)
    end, 'replace', 1)

    love.graphics.setStencilTest('less', 1)

	self.player:render()

	love.graphics.setStencilTest()

end