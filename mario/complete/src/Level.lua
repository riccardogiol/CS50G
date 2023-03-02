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
	for c = 1, self.mapWidth do
		isChasm = math.random(9) == 1
		if isChasm then
			goto continue
		end
		local top = 6
		isPillar = math.random(6) == 1
		if isPillar then
			top = top - 2
		end
		for r = 1, self.mapHeight do
			if r >= top then
				map[r][c].tileType =  TILE_CODES['GROUND']
			end
			if r == top then
				map[r][c].isTopper = true
			end
		end
		::continue::
	end

	return map
end

--[[
function Level:randomiseTiles()
	self.tileGroup = math.random(#self.tileSets)
	self.topGroup = math.random(#self.topSets)
end]]

function Level:tileFromPoint(x, y)
	if x<0 or x> self.mapWidth*TILE_SIZE or y<0 or y>self.mapHeight*TILE_SIZE then
		return nil
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