PlayState = Class{__includes = BaseState}

function PlayState:enter(enterParams)
	self.board = enterParams.board
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
				self.selector.blocked = true
				tweenTiles(self.selectedTile.row, self.selectedTile.col, self.selector.row, self.selector.col)
				self.selector.blocked = false
				self.selectedTile.selected = false
				--self.matches = giveMatches(self.board)
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

function PlayState:render()
	-- print board
	love.graphics.setColor(1, 1, 1, 1)
	for j=0,7 do
		for i=0,7 do
			self.board[j][i]:render(OFFSET_X, OFFSET_Y)
		end
	end

	-- print selector
	love.graphics.setColor(1, 0, 0, 1)
	love.graphics.setLineWidth(4)
	local selectorX, selectorY = self.board[self.selector.row][self.selector.col]:getPosition()
	love.graphics.rectangle('line', OFFSET_X + selectorX, OFFSET_Y + selectorY, self.selector.dim, self.selector.dim)

	-- print selected tile
	if self.selectedTile.selected then
		local selectedX, selectedY = self.board[self.selectedTile.row][self.selectedTile.col]:getPosition()
		love.graphics.setColor(1, 1, 1, 0.3)
		love.graphics.rectangle('fill', OFFSET_X + selectedX, OFFSET_Y + selectedY, TILE_SIZE, TILE_SIZE)
	end

	-- print matches
	for j, m in pairs(self.matches) do
		for i, t in pairs(m) do
			love.graphics.setColor(1, 1, 1, 1)

			love.graphics.print(tostring(t.row) .. " " .. tostring(t.col) .. ",", i*20, 30 + j*20)
		end
	end

end 