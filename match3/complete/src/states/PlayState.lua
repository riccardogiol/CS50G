PlayState = Class{__includes = BaseState}

function PlayState:enter(enterParams)
	self.board = enterParams.board
	self.colors = enterParams.colors
	self.numSymbols = enterParams.numSymbols
	self.selector = {
		row = 0,
		col = 0,
		dim = TILE_SIZE,
		blocked = false
	}
	self.selectedTile = {
		row = 0,
		col = 0,
		selected = false
	}
	self.matches = giveMatches(self.board)
end 

function PlayState:update()
	if not self.selector.blocked then
		if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
			if not self.selectedTile.selected then
				self.selectedTile.row = self.selector.row
				self.selectedTile.col = self.selector.col
				self.selectedTile.selected = true
			else
				self:tweenTiles(self.selectedTile.row, self.selectedTile.col, self.selector.row, self.selector.col)
				self.selectedTile.selected = false
			end
		end

		if love.keyboard.wasPressed('right') then
			if self.selectedTile.selected then
				self.selector.col = math.min(self.selector.col + 1, self.selectedTile.col + 1, NUM_COL - 1)
				self.selector.row = self.selectedTile.row
			else
				self.selector.col = math.min(self.selector.col + 1, NUM_COL - 1)
			end
		elseif love.keyboard.wasPressed('left') then
			if self.selectedTile.selected then
				self.selector.col = math.max(self.selector.col - 1, self.selectedTile.col - 1, 0)
				self.selector.row = self.selectedTile.row
			else
				self.selector.col = math.max(self.selector.col - 1, 0)
			end
		elseif love.keyboard.wasPressed('up') then
			if self.selectedTile.selected then
				self.selector.row = math.max(self.selector.row - 1, self.selectedTile.row - 1, 0)
				self.selector.col = self.selectedTile.col
			else
				self.selector.row = math.max(self.selector.row - 1, 0)
			end
		elseif love.keyboard.wasPressed('down') then
			if self.selectedTile.selected then
				self.selector.row = math.min(self.selector.row + 1, self.selectedTile.row + 1, NUM_ROW - 1)
				self.selector.col = self.selectedTile.col
			else
				self.selector.row = math.min(self.selector.row + 1, NUM_ROW - 1)
			end
		end
	end

    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
end 


function PlayState:tweenTiles(tile1row, tile1col, tile2row, tile2col)
	tile1ref = self.board[tile1row][tile1col].tile
	tile1val = Tile(tile1ref.quad, tile1ref.color, tile1ref.x, tile1ref.y, tile1ref.w, tile1ref.h)
	tile2ref = self.board[tile2row][tile2col].tile
	self.selector.blocked = true
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
		tile1ref = self.board[tile1row][tile1col].tile
		self.board[tile1row][tile1col].tile = self.board[tile2row][tile2col].tile
		self.board[tile2row][tile2col].tile = tile1ref
		self.matches = giveMatches(self.board)
		self:removeMatches()
		self:allignBottom()
		self:fillTop()
		
		self.selector.blocked = false

	end)

end

function PlayState:removeMatches()
	for j, m in pairs(self.matches) do
		for i, t in pairs(m) do
			self.board[t.row][t.col].tile = nil
		end
	end
end

function PlayState:allignBottom()
	for j = 0, NUM_COL -1 do
		for i = NUM_ROW - 1, 0, -1 do
			if not self.board[i][j].tile then
				local e = i
				repeat
					e = e - 1
				until (e < 0 or board[e][j].tile) 

				if e >= 0 then
					self:moveTile(e, j, i, j)
				end
			end
		end
	end
end

function PlayState:moveTile(fromR, fromC, toR, toC)
	local tileAux = self.board[toR][toC].tile
	self.board[toR][toC].tile = self.board[fromR][fromC].tile
	self.board[fromR][fromC].tile = tileAux
	local duration = (self.board[toR][toC].y - self.board[toR][toC].tile.y) / 96
	Timer.tween(duration, {
		[self.board[toR][toC].tile] = {
			x = self.board[toR][toC].x,
			y = self.board[toR][toC].y
		}
	})
end


function PlayState:fillTop()
	tileQuads = generateTileQuads(gTexture['tiles'], TILE_SIZE, 18, 6)
	numColr = 0
	for i, c in pairs(colors) do
		numColr = numColr + 1
	end
	for j = 0, NUM_COL -1 do
		seriePosition = 0
		for i = NUM_ROW - 1, 0, -1 do
			if not self.board[i][j].tile then
				self:addNewTile(tileQuads, numColr, i, j, seriePosition)
				seriePosition = seriePosition +1
			end
		end
	end
end


function PlayState:addNewTile(tileQuads, numColr, toR, toC, seriePosition)
	local col = self.colors[math.random(0, numColr-1)]
	local sym = math.random(0, self.numSymbols-1)

	startingY = -60 - seriePosition * (TILE_SIZE + 4)

	newTile = Tile(tileQuads[col][sym], col, toC*TILE_SIZE, startingY, TILE_SIZE, TILE_SIZE)

	self.board[toR][toC].tile = newTile

	local duration = (self.board[toR][toC].y - startingY) / 96
	Timer.tween(duration, {
		[self.board[toR][toC].tile] = {
			x = self.board[toR][toC].x,
			y = self.board[toR][toC].y
		}
	})
end


function PlayState:render()
	-- print board
	love.graphics.setColor(1, 1, 1, 1)
	for j, r in pairs(self.board) do
		for i, t in pairs(r) do
			if t.tile then
				t.tile:render(OFFSET_X, OFFSET_Y)
			end
		end
	end

	-- print selector
	love.graphics.setColor(1, 0, 0, 1)
	love.graphics.setLineWidth(4)
	local selectorPosOnBoard = self.board[self.selector.row][self.selector.col]
	local selectorX, selectorY = selectorPosOnBoard.x, selectorPosOnBoard.y
	love.graphics.rectangle('line', OFFSET_X + selectorX, OFFSET_Y + selectorY, self.selector.dim, self.selector.dim)

	-- print selected tile
	if self.selectedTile.selected then
		local selectionPosOnBoard = self.board[self.selectedTile.row][self.selectedTile.col]
		local selectedX, selectedY = selectionPosOnBoard.x, selectionPosOnBoard.y
		love.graphics.setColor(1, 1, 1, 0.3)
		love.graphics.rectangle('fill', OFFSET_X + selectedX, OFFSET_Y + selectedY, TILE_SIZE, TILE_SIZE)
	end

	-- print matches
	for j, m in pairs(self.matches) do
		for i, t in pairs(m) do
			love.graphics.setColor(1, 1, 1, 1)
			love.graphics.print(tostring(t.row) .. " " .. tostring(t.col) .. ",", i*30, 30 + j*20)
		end
	end

end 