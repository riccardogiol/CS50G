function generateTileQuads(atlas, dim, numColr, numSymbl)
	tileQuads = {}
	counterColor = 0
	for j=0,(numColr/2)-1 do 
		local newRow = {}
		for i=0,numSymbl-1 do
			newRow[i] = love.graphics.newQuad(i*dim, j*dim, dim, dim, atlas:getDimensions())
		end
		tileQuads[counterColor] = newRow
		counterColor = counterColor + 1
	end
	for j=0,(numColr/2)-1 do 
		local newRow = {}
		for i=0,numSymbl-1 do
			newRow[i] = love.graphics.newQuad((dim*numSymbl)+i*dim, j*dim, dim, dim, atlas:getDimensions())
		end
		tileQuads[counterColor] = newRow
		counterColor = counterColor + 1
	end
	return tileQuads
end

function generateBoard(tileQuads, numRows, numCols, tileDim, numColr, numSymbl)
	board = {}
	colors = {}
	for c=0, numColr-1 do
		local newCol = 0
		repeat
			same = false
			newCol = math.random(0, 17)
			for i=0,c do
				if colors[i] == newCol then
					same = true
				end
			end
		until not same
		colors[c] = newCol
	end
	for j=0,numRows do
		local newRow = {}
		for i=0, numCols do
			local col = colors[math.random(0, numColr-1)]
			local sym = math.random(0, numSymbl-1)
			newRow[i] = Tile(tileQuads[col][sym], i*tileDim, j*tileDim, tileDim, tileDim)
		end
		board[j] = newRow
	end
	return board
end






