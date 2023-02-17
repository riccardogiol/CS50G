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

function swapTiles(tile1row, tile1col, tile2row, tile2col)
	auxTile1quad = board[tile1row][tile1col].quad
	board[tile1row][tile1col].quad = board[tile2row][tile2col].quad
	board[tile2row][tile2col].quad = auxTile1quad
end

function tweenTiles(tile1row, tile1col, tile2row, tile2col)
	tile1ref = board[tile1row][tile1col]
	tile1val = Tile(tile1ref.quad, tile1ref.x, tile1ref.y, tile1ref.w, tile1ref.h)
	tile2ref = board[tile2row][tile2col]
	selector.blocked = true
	Timer.tween(0.5, {
		[tile1ref] = {
			x = tile2ref.x,
			y = tile2ref.y
		},
		[tile2ref] = {
			x = tile1val.x,
			y = tile1val.y
		}
	}):finish(function()
		tile1ref = board[tile1row][tile1col]
		board[tile1row][tile1col] = board[tile2row][tile2col]
		board[tile2row][tile2col] = tile1ref
		selector.row, selector.col = tile1row, tile1col
		selector.blocked = false
	end)

end




