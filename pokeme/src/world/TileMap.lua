TileMap = Class{}

function TileMap:init(mapWidth, mapHeight)
	self.mapWidth = mapWidth
	self.mapHeight = mapHeight
	self.tiles = {}
	for y = 1, self.mapHeight do
		self.tiles[y] = {}
		for x = 1, self.mapWidth do
			self.tiles[y][x] = Tile((x-1)*TILE_SIZE, (y-1)*TILE_SIZE, TILE_IDS['grass'][math.random(#TILE_IDS['grass'])])
		end
	end
end

function TileMap:render()
	for y = 1, self.mapHeight do
		for x = 1, self.mapWidth do
			self.tiles[y][x]:render()
		end
	end
end

function TileMap:renderForegroundObjects(player)
	local tile = self.tiles[player.mapY][player.mapX]
	local yDiff = player.y < tile.y - (player.height - TILE_SIZE) -2
	if tile.id == TILE_IDS['tall-grass'] and yDiff then
		love.graphics.draw(gTextures['tiles'], gFrames['tiles'][TILE_IDS['half-tall-grass']], tile.x, tile.y)
	end
end

function TileMap:walkableTile(x, y)
	if x < 1 or x > self.mapWidth then
		return false
	elseif y < 1 or y > self.mapHeight then
		return false
	end
	return true
end


function TileMap:randomizeMap()
	local num_1_flower = math.random(10, 15)
	local num_2_flower = math.random(4, 8)
	local num_3_flower = math.random(5)
	for i = 1, num_1_flower do
		local x = math.random(self.mapWidth)
		local y = math.random(self.mapHeight)
		self.tiles[y][x].id = TILE_IDS['single-flower'][math.random(#TILE_IDS['single-flower'])]
	end
	for i = 1, num_2_flower do
		local x = math.random(self.mapWidth)
		local y = math.random(self.mapHeight)
		self.tiles[y][x].id = TILE_IDS['double-flower'][math.random(#TILE_IDS['double-flower'])]
	end
	for i = 1, num_3_flower do
		local x = math.random(self.mapWidth)
		local y = math.random(self.mapHeight)
		self.tiles[y][x].id = TILE_IDS['triple-flower'][math.random(#TILE_IDS['triple-flower'])]
	end
	for c = math.floor(3*self.mapWidth/5), math.floor(4*self.mapWidth/5) do
		for r = 1, self.mapHeight do
			if math.random(5) == 1 then
				self.tiles[r][c].id = TILE_IDS['tall-grass']
			end
		end
	end
	for c = math.floor(4*self.mapWidth/5), self.mapWidth do
		for r = 1, self.mapHeight do
			if math.random(10) > 1 then
				self.tiles[r][c].id = TILE_IDS['tall-grass']
			end
		end
	end
end