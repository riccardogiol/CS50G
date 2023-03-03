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

	self.tileMap = self:generateMap()
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
	for c = 1, self.mapWidth do
		local top = 8
		isChasm = math.random(9) == 1
		if isChasm then
			goto continue
		end
		isPillar = math.random(6) == 1
		isPlatform = math.random(15) == 1
		if isPlatform then
			platformCount = 3
		end
		if isPillar then
			top = top - 3
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

--[[
function Level:randomiseTiles()
	self.tileGroup = math.random(#self.tileSets)
	self.topGroup = math.random(#self.topSets)
end]]

function Level:tileFromPoint(x, y)
	--[[if x<0 or x> self.mapWidth*TILE_SIZE or y<0 or y>self.mapHeight*TILE_SIZE then
		return nil
	end]]
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


function Level:render()
	for y = 1, self.mapHeight do
		for x = 1 , self.mapWidth do
			self.tileMap[y][x]:render()
		end
	end
end