Position = Class{}

function Position:init(row, col)
	self.row = row
	self.col = col
end


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


function tweenTiles(tile1row, tile1col, tile2row, tile2col)
	tile1ref = board[tile1row][tile1col]
	tile1val = Tile(tile1ref.quad, tile1ref.color, tile1ref.x, tile1ref.y, tile1ref.w, tile1ref.h)
	tile2ref = board[tile2row][tile2col]
	Timer.tween(0.2, {
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
	end)

end

function giveMatches(board)
	matches = {}
	local numMatch = 0
	for r = 0, NUM_ROW -1 do
		local onAStrike = false
		local previousColor =  nil
		local strikeLength = 0
		for c = 0, NUM_COL - 1 do
			if board[r][c].color == previousColor then
				onAStrike = true
				strikeLength = strikeLength + 1
			else
				if strikeLength >= 2 then
					matches[numMatch] = generateMatchBackwards(board, r, c-1, strikeLength)
					numMatch = numMatch + 1
				end
				onAStrike = false
				strikeLength = 0
			end
			previousColor = board[r][c].color
		end
		if strikeLength >= 2 then
			matches[numMatch] = generateMatchBackwards(board, r, NUM_COL - 1, strikeLength)
			numMatch = numMatch + 1
		end
	end
	return matches
end

function generateMatchBackwards(board, r, c, length)
	if length > c -1 then
		return nil
	end
	match = {}
	for i = 0, length do
		match[i] = Position(r, c-i)
	end
	return match
end

