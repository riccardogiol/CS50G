PlayerWalkState = Class{__includes = BaseState}

function PlayerWalkState:init(player, tileMap)
	self.player = player
	self.tileMap = tileMap
	self.walking = false
	self.player:changeAnimation('walk-' .. self.player.direction)
end

function PlayerWalkState:update(dt)
	self.player.currentAnimation:update(dt)
	if self.walking then
		return
	end
	local finalMapX = self.player.mapX
	local finalMapY = self.player.mapY
	local finalX = self.player.x
	local finalY = self.player.y
	self.walking = true
	if self.player.direction == 'left' then
		finalMapX = finalMapX - 1
		finalX = finalX - TILE_SIZE
	elseif self.player.direction == 'right' then
		finalMapX = finalMapX + 1
		finalX = finalX + TILE_SIZE
	elseif self.player.direction == 'up' then
		finalMapY = finalMapY - 1
		finalY = finalY - TILE_SIZE
	elseif self.player.direction == 'down' then
		finalMapY = finalMapY + 1
		finalY = finalY + TILE_SIZE
	end

	if not self.tileMap:walkableTile(finalMapX, finalMapY) then
		self.player:changeState('idle')
	else
		self.player.mapX = finalMapX
		self.player.mapY = finalMapY
		self:checkEncounters()
		Timer.tween(0.3, {
			[self.player] = {x = finalX, y = finalY}
		}):finish(
		function()
			if love.keyboard.isDown('left') then
				self.player.direction = 'left'
				self.player:changeState('walk')
			elseif love.keyboard.isDown('right') then
				self.player.direction = 'right'
				self.player:changeState('walk')
			elseif love.keyboard.isDown('up') then
				self.player.direction = 'up'
				self.player:changeState('walk')
			elseif love.keyboard.isDown('down') then
				self.player.direction = 'down'
				self.player:changeState('walk')
			else
				self.player:changeState('idle')
			end
		end)
	end
end

function PlayerWalkState:checkEncounters()
	if self.tileMap.tiles[self.player.mapY][self.player.mapX].id == TILE_IDS['tall-grass'] then
		if math.random(5) == 1 then
			gStateStack:push(FadeState(
			{ r = 1, g = 1, b = 1, a = 0},
			{ r = 1, g = 1, b = 1, a = 1},
			0.5, 
			function()
				gStateStack:push(BattleState(self.player))
				gStateStack:push(FadeState(
					{ r = 1, g = 1, b = 1, a = 1},
					{ r = 1, g = 1, b = 1, a = 0},
					0.5, 
					function() end))
			end))
		end
	end
end

function PlayerWalkState:render() end
