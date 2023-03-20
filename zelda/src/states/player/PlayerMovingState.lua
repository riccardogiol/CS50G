PlayerMovingState = Class{__includes = BaseState}

function PlayerMovingState:init(player, dungeon)
	self.player = player
	self.dungeon = dungeon
end

function PlayerMovingState:enter(enterParams)
	self.player:changeAnimation('walk-' .. self.player.direction)
end

function PlayerMovingState:update(dt)
	if love.keyboard.isDown('left') then
		self.player.direction = 'left'
		self.player:changeAnimation('walk-left')
	elseif love.keyboard.isDown('right') then
		self.player.direction = 'right'
		self.player:changeAnimation('walk-right')
	elseif love.keyboard.isDown('up') then
		self.player.direction = 'up'
		self.player:changeAnimation('walk-up')
	elseif love.keyboard.isDown('down') then
		self.player.direction = 'down'
		self.player:changeAnimation('walk-down')
	else
		self.player:changeState('idle')
	end
	touchedWall = self.player:move(dt)
	if touchedWall then
		if self.player.direction == 'left' then
			if self.player:collidesOffset(- self.player.walkSpeed * dt, 0, self.dungeon.currentRoom.doors['left']) and self.dungeon.currentRoom.doors['left'].open then
				Event.dispatch('shift-left')
			end
		elseif self.player.direction == 'right' then
			if self.player:collidesOffset(self.player.walkSpeed * dt, 0, self.dungeon.currentRoom.doors['right']) and self.dungeon.currentRoom.doors['right'].open then
				Event.dispatch('shift-right')
			end
		elseif self.player.direction == 'up' then
			if self.player:collidesOffset(0, - self.player.walkSpeed * dt, self.dungeon.currentRoom.doors['up']) and self.dungeon.currentRoom.doors['up'].open then
				Event.dispatch('shift-up')
			end
		elseif self.player.direction == 'down' then
			if self.player:collidesOffset(0, self.player.walkSpeed * dt, self.dungeon.currentRoom.doors['down']) and self.dungeon.currentRoom.doors['down'].open then
				Event.dispatch('shift-down')
			end
		end
	end

end


function PlayerMovingState:render()
	local anim = self.player.currentAnimation
	love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
		(self.player.x - self.player.offsetX), (self.player.y - self.player.offsetY))
end