
function generateQuads(atlas, tileWidth, tileHeight)
	local numCol = atlas:getWidth() / tileWidth
	local numRow = atlas:getHeight() / tileHeight

	local spriteSheet = {}
	local sheetCounter = 1

	for r = 0, numRow - 1 do
		for c = 0, numCol - 1 do
			spriteSheet[sheetCounter] = love.graphics.newQuad(c * tileWidth, r * tileHeight, tileWidth, tileHeight, atlas:getDimensions())
			sheetCounter = sheetCounter + 1
		end
	end
	return spriteSheet
end

function generateQuadsGroups(quads, groupRows, groupColumns, rowsPerGroup, colsPerGroup)
	numGroups = (#quads) / (colsPerGroup * rowsPerGroup )
	quadsPerRow = groupColumns * colsPerGroup

	quadsGroups = {}
	groupCounter = 1

	for gr = 0, groupRows - 1 do
		for gc = 0, groupColumns -1 do
			newGroup = {}
			newGroupCounter = 1
			offsetX = gc * colsPerGroup
			offsetY = gr * rowsPerGroup * quadsPerRow
			for r = 0, rowsPerGroup - 1 do
				for c = 0, colsPerGroup -1 do
					position = (offsetY + offsetX + c + r * quadsPerRow) + 1
					newGroup[newGroupCounter] = quads[position]
					newGroupCounter = newGroupCounter + 1
				end
			end
			quadsGroups[groupCounter] = newGroup
			groupCounter = groupCounter + 1
		end
	end
	return quadsGroups
end

function generateMap()
	map = {}


	for r = 1, mapHeight do
		newRow = {}
		for c = 1, mapWidth do
			newRow[c] = {
				id = SKY,
				top = false
			}
		end
		map[r] = newRow
	end

	for c = 1, mapWidth do
		isChasm = math.random(9) == 1
		if isChasm then
			goto continue
		end
		local top = 6
		isPillar = math.random(6) == 1
		if isPillar then
			top = top - 3
		end
		for r = 1, mapHeight do
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
