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

function generateMatchBackwards(r, c, length)
	if length > c + 1 then
		return nil
	end
	match = {}
	for i = 0, length-1 do
		match[i] = Position(r, c-i)
	end
	return match
end

function generateMatchUpwards(r, c, length)
	if length > r + 1 then
		return nil
	end
	match = {}
	for i = 0, length-1 do
		match[i] = Position(r - i, c)
	end
	return match
end

