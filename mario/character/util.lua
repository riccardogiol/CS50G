
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
