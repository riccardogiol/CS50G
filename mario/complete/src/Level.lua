--LevelMaker = Class{}
Level = Class{}

SKY = 5
GROUND = 3

function Level:init(mapWidth, mapHeight)
	self.mapWidth = mapWidth
	self.mapHeight = mapHeight

	self.tileMap = self:generateMap()

	local tileGroupRows = 10
	local tileGroupColumns = 6
	local topGroupRows = 18
	local topGroupColumns = 6
	local rowsPerGroup = 4
	local colsPerGroup = 5
	
	local tilesRawQuads = generateQuads(gTexture['tiles'], TILE_SIZE, TILE_SIZE)
	self.tileSets = generateQuadsGroups(tilesRawQuads, tileGroupRows, tileGroupColumns, rowsPerGroup, colsPerGroup)

	local topRawQuads = generateQuads(gTexture['tile_tops'], TILE_SIZE, TILE_SIZE)
	self.topSets = generateQuadsGroups(topRawQuads, topGroupRows, topGroupColumns, rowsPerGroup, colsPerGroup)

	self.tileGroup = math.random(#self.tileSets)
	self.topGroup = math.random(#self.topSets)
end


function Level:generateMap()
	map = {}

	-- initialise empty map
	for r = 1, self.mapHeight do
		newRow = {}
		for c = 1, self.mapWidth do
			newRow[c] = {
				id = SKY,
				top = false
			}
		end
		map[r] = newRow
	end

	--fill map with ground and objects
	for c = 1, self.mapWidth do
		isChasm = math.random(9) == 1
		if isChasm then
			goto continue
		end
		local top = 6
		isPillar = math.random(6) == 1
		if isPillar then
			top = top - 3
		end
		for r = 1, self.mapHeight do
			if r >= top then
				map[r][c].id = GROUND
			end
			if r == top then
				map[r][c].top = true
			end
		end
		::continue::
	end

	return map
end

function Level:randomiseTiles()
	self.tileGroup = math.random(#self.tileSets)
	self.topGroup = math.random(#self.topSets)
end


function Level:render()
	for y = 1, self.mapHeight do
		for x = 1 , self.mapWidth do
			love.graphics.draw(gTexture['tiles'], self.tileSets[self.tileGroup][self.tileMap[y][x].id], (x-1) * TILE_SIZE, (y-1) * TILE_SIZE)
			if self.tileMap[y][x].top then
				love.graphics.draw(gTexture['tile_tops'], self.topSets[self.topGroup][1], (x-1) * TILE_SIZE, (y-1) * TILE_SIZE)
			end
		end
	end
end