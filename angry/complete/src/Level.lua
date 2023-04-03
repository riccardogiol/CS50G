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
		self.groundTiles[i]:setUserData('Ground')
	end

	self.AlienLauncher = AlienLauncher(self.world)

	local towerXOffset = 450
	self.obstacles = {}
	self.enemies = {}
	self.enemies[1] = Alien(self.world, 'square', towerXOffset + 50 , 200, 'dynamic', 'Alien')
	self.obstacles[1] = Obstacle(self.world, 'vertical', towerXOffset, 200)
	self.obstacles[2] = Obstacle(self.world, 'vertical', towerXOffset + 100, 200)
	self.obstacles[3] = Obstacle(self.world, 'horizontal', towerXOffset + 50, 127)

	self.destroyedBodies = {}

	function beginContact(a, b, coll)
		local types={}
		types[a:getUserData()] = true
		types[b:getUserData()] = true


		--'Obstacle' 'Player' 'Alien' 'Ground'

		if types['Player'] and types['Obstacle'] then
			local playerFixture = nil
			local obstacleFixture = nil
			if a:getUserData() == 'Player' then
				playerFixture = a
				obstacleFixture = b
			else
				playerFixture = b
				obstacleFixture = a
			end
			local plyVelX, plyVelY = playerFixture:getBody():getLinearVelocity()
			local plyVel = math.sqrt(plyVelX^2 + plyVelY^2)
			if plyVel > 200 then
				table.insert(self.destroyedBodies, obstacleFixture:getBody())
			end
		end
		if types['Player'] and types['Alien'] then
			local playerFixture = nil
			local alienFixture = nil
			if a:getUserData() == 'Player' then
				playerFixture = a
				alienFixture = b
			else
				playerFixture = b
				alienFixture = a
			end
			local plyVelX, plyVelY = playerFixture:getBody():getLinearVelocity()
			local plyVel = math.sqrt(plyVelX^2 + plyVelY^2)
			if plyVel > 200 then
				table.insert(self.destroyedBodies, alienFixture:getBody())
			end
		end
		if types['Obstacle'] and types['Alien'] then
			local obstacleFixture = nil
			local alienFixture = nil
			if a:getUserData() == 'Obstacle' then
				obstacleFixture = a
				alienFixture = b
			else
				obstacleFixture = b
				alienFixture = a
			end
			local obsVelX, obsVelY = obstacleFixture:getBody():getLinearVelocity()
			local obsVel = math.sqrt(obsVelX^2 + obsVelY^2)
			if obsVel > 100 then
				table.insert(self.destroyedBodies, alienFixture:getBody())
			end
		end
	end

	function endContact(a, b, coll) end

	function preSolve(a, b, coll) end

	function postSolve(a, b, coll, normalImpulse, tangentImpulse) end

	self.world:setCallbacks(beginContact, endContact, preSolve, postSolve)
end

function Level:update(dt, levelTranslation)
	self.world:update(dt)
	self.AlienLauncher:update(dt, levelTranslation)

	for i, db in pairs(self.destroyedBodies) do
		if not db:isDestroyed() then
			db:destroy()
		end
	end

	self.destroyedBodies = {}

	for i = # self.obstacles, 1, -1 do
		if self.obstacles[i].body:isDestroyed() then
			table.remove(self.obstacles, i)
		end
	end
	for i = # self.enemies, 1, -1 do
		if self.enemies[i].body:isDestroyed() then
			table.remove(self.enemies, i)
		end
	end

	if self.AlienLauncher.launched then
        local xPos, yPos = self.AlienLauncher.alien.body:getPosition()
        local xVel, yVel = self.AlienLauncher.alien.body:getLinearVelocity()
        
        if xPos < 0 or (math.abs(xVel) + math.abs(yVel) < 1.5) or xPos > VIRTUAL_WIDTH*1.2 then
            self.AlienLauncher.alien.body:destroy()
            self.AlienLauncher = AlienLauncher(self.world)

            if #self.enemies <= 0 then
            	gStateMachine:change('start')
            end

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
	for i, en in pairs(self.enemies) do
		en:render()
	end
	self.AlienLauncher:render()
end