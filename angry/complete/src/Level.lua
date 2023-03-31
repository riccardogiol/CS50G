Level = Class{}

function Level:init()
	self.world = love.physics.newWorld(0, 300)

	self.groundTiles = {}
	local tilesPerWindow = math.ceil(VIRTUAL_WIDTH/TILE_SIZE)
	for i = 1, tilesPerWindow*3 do
		local groundTileBody = love.physics.newBody(self.world, -VIRTUAL_WIDTH + (i - 1) * TILE_SIZE, VIRTUAL_HEIGHT - TILE_SIZE/2, 'static')
		local groundTileShape = love.physics.newRectangleShape(TILE_SIZE, TILE_SIZE)
		self.groundTiles[i] = love.physics.newFixture(groundTileBody, groundTileShape)
		self.groundTiles[i]:setFriction(0.5)
	end

	self.AlienLauncher = AlienLauncher(self.world)

	self.obstacles = {}
	local towerXOffset = 450
	self.enemy = Alien(self.world, 'square', towerXOffset + 50 , 200)
	self.obstacles[1] = Obstacle(self.world, 'vertical', towerXOffset, 200)
	self.obstacles[2] = Obstacle(self.world, 'vertical', towerXOffset + 100, 200)
	self.obstacles[3] = Obstacle(self.world, 'horizontal', towerXOffset + 50, 127)
end

function Level:update(dt)
	self.world:update(dt)
	self.AlienLauncher:update(dt)

	if self.AlienLauncher.launched then
        local xPos, yPos = self.AlienLauncher.alien.body:getPosition()
        local xVel, yVel = self.AlienLauncher.alien.body:getLinearVelocity()
        
        if xPos < 0 or (math.abs(xVel) + math.abs(yVel) < 1.5) or xPos > VIRTUAL_WIDTH*1.2 then
            self.AlienLauncher.alien.body:destroy()
            self.AlienLauncher = AlienLauncher(self.world)

        end
    end

end

function Level:render()
	for i, gt in pairs(self.groundTiles) do
		love.graphics.draw(gTextures['tiles'], gFrames['tiles'][12], gt:getBody():getX(), gt:getBody():getY(), 0, 1, 1, TILE_SIZE/2, TILE_SIZE/2)
	end
	for i, ob in pairs(self.obstacles) do
		ob:render()
	end
	self.AlienLauncher:render()
	self.enemy:render()
end