--LevelMaker = Class{}
Level = Class{}

TILE_CODES = {
	SKY = {
		POS = 5,
		COLL = false
	},
	GROUND = {
		POS = 3,
		COLL = true
	}
}

function Level:init(mapWidth, mapHeight)
	self.mapWidth = mapWidth
	self.mapHeight = mapHeight

	self.tileGroup = math.random(#gTileQuads)
	self.topGroup = math.random(#gTopQuads)

	self.blocks = {}
	self.tileMap = self:generateMap()

	self:poseNextLevelBlock()
	self.enemies = self:generateEnemies()
	self.bushes = self:generateBushes()
end


function Level:generateMap()
	map = {}

	-- initialise empty map
	for r = 1, self.mapHeight do
		newRow = {}
		for c = 1, self.mapWidth do
			newRow[c] = Tile((c-1) * TILE_SIZE, (r-1) * TILE_SIZE, TILE_CODES['SKY'], false, self.tileGroup, self.topGroup)
		end
		map[r] = newRow
	end

	--fill map with ground and objects
	platformCount = 0
	hillCount = 0
	pillarCount = 0
	chasmCount = 0
	local top = 8
	for c = 1, self.mapWidth do
		top = 8

		isChasm = math.random(12) == 1
		if isChasm then
			chasmCount = math.random(2)
		end

		if chasmCount > 0 then
			chasmCount = chasmCount - 1
			goto continue
		end

		isPillar = math.random(9) == 1
		if isPillar then
			pillarCount = math.random(3)
		end

		isPlatform = math.random(20) == 1
		if isPlatform then
			platformCount = 3
		end

		hillBegins = math.random(30) == 1
		if hillBegins then
			hillCount = 20
		end

		if hillCount > 0 then
			top = top - 1
			hillCount = hillCount -1
		end

		if pillarCount > 0 and not hillBegins then
			isPillar = true
			top = top - 3
			pillarCount = pillarCount - 1
		end
		for r = 1, self.mapHeight do
			if r >= top then
				map[r][c].tileType =  TILE_CODES['GROUND']
				if r == top then
					map[r][c].isTopper = true
				end
			end
		end
		::continue::
		if platformCount > 0 then
			if isPillar then
				map[top][c].tileType =  TILE_CODES['GROUND']
				map[top][c].isTopper = true
			else
				map[top-3][c].tileType =  TILE_CODES['GROUND']
				map[top-3][c].isTopper = true
			end
			platformCount = platformCount - 1
		end

	end
	-- hard write the first 10 columns
	for c = 1, 10 do
		for r = 1, self.mapHeight do
			map[r][c].tileType =  TILE_CODES['SKY']
			map[r][c].isTopper = false
			if r >= 6 then
				map[r][c].tileType =  TILE_CODES['GROUND']
			end
			if r == 6 then
				map[r][c].isTopper = true
			end
		end
	end
	return map
end

function Level:poseNextLevelBlock()
	for r = 1, self.mapHeight do
		if self.tileMap[r][self.mapWidth].isTopper then
			local nextLevelBlock
			nextLevelBlock = Object({
				x = self.tileMap[r - 1][self.mapWidth].x,
				y = self.tileMap[r - 1][self.mapWidth].y,
				width = TILE_SIZE,
				height = TILE_SIZE,
				solid = true,
				texture = 'jump-blocks',
				frame = 9,
				onCollide = function ()
					return {
						nextLevel = true
					}
				end
			})
			table.insert(self.blocks, nextLevelBlock)
		end
	end
end

function Level:generateEnemies()
	snails = {}

	for c = 1, self.mapWidth do
		if math.random(15) > 1 then
			goto nextColumn
		end
		groundFound = false
		for r = 1, self.mapHeight do
			if not groundFound then
				if self.tileMap[r][c].isTopper then
					groundFound = true
					local snail
					snail = Snail({
						x = self.tileMap[r - 1][c].x,
						y = self.tileMap[r - 1][c].y,
						width = TILE_SIZE,
						height = TILE_SIZE,
						dx = 0,
						dy = 0,
						direction = 'left',
						texture = 'snail',
						level = self,
						stateMachine = StateMachine {
							['idle'] = function() return SnailIdleState(snail) end,
							['moving'] = function() return SnailMovingState(snail) end,
							['dead'] = function() return SnailDeadState(snail) end
						}
					})
					snail:changeState('idle')
					table.insert(snails, snail)
				end
			end
		end
		::nextColumn::
	end
	return snails
end

GOOD_BUSHES = {
	1, 2, 5, 6, 7
}
function Level:generateBushes()
	bushes = {}
	bushColor = math.random(5)

	for c = 1, self.mapWidth do
		if math.random(8) > 1 then
			goto nextColumn
		end
		groundFound = false
		for r = 1, self.mapHeight do
			if not groundFound then
				if self.tileMap[r][c].isTopper then
					groundFound = true
					local bush
					bush = Object({
						x = self.tileMap[r - 1][c].x,
						y = self.tileMap[r - 1][c].y,
						width = TILE_SIZE,
						height = TILE_SIZE,
						solid = false,
						texture = 'bushes',
						frame = (bushColor - 1) * 7 + GOOD_BUSHES[math.random(#GOOD_BUSHES)],
					})
					table.insert(bushes, bush)
				end
			end
		end
		::nextColumn::
	end
	return bushes
end


function Level:tileFromPoint(x, y)
	if x < 0 then
		return Tile(-TILE_SIZE, y, TILE_CODES['GROUND'], false, self.tileGroup, self.topGroup)
	elseif x > self.mapWidth * TILE_SIZE then
		return Tile(self.mapWidth*TILE_SIZE, y, TILE_CODES['GROUND'], false, self.tileGroup, self.topGroup)
	elseif y < 0 then
		return Tile(x, y, TILE_CODES['SKY'], false, self.tileGroup, self.topGroup)
	elseif y > self.mapHeight*TILE_SIZE then
		return Tile(x, self.mapHeight*TILE_SIZE, TILE_CODES['GROUND'], false, self.tileGroup, self.topGroup)
	end
	return self.tileMap[math.ceil(y/TILE_SIZE)][math.ceil(x/TILE_SIZE)]
end

function Level:update(dt)
	for i, e in pairs(self.enemies) do
		e:update(dt)
	end
end

function Level:render()
	for y = 1, self.mapHeight do
		for x = 1 , self.mapWidth do
			self.tileMap[y][x]:render()
		end
	end
	for i, b in pairs(self.bushes) do
		b:render()
	end
	for i, bl in pairs(self.blocks) do
		bl:render()
	end
	for i, e in pairs(self.enemies) do
		e:render()
	end
end