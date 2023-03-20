PlayerMovingState = Class{__includes = BaseState}

function PlayerMovingState:init(player)
	self.player = player
end

function PlayerMovingState:enter(enterParams)
	self.player:changeAnimation('walk-' .. self.player.direction)
end

function PlayerMovingState:update(dt)
	if love.keyboard.isDown('left') then
		self.player.direction = 'left'
		self.player:changeAnimation('walk-left')
		self.player.x = self.player.x - self.player.walkSpeed * dt
	elseif love.keyboard.isDown('right') then
		self.player.direction = 'right'
		self.player:changeAnimation('walk-right')
		self.player.x = self.player.x + self.player.walkSpeed * dt
	elseif love.keyboard.isDown('up') then
		self.player.direction = 'up'
		self.player:changeAnimation('walk-up')
		self.player.y = self.player.y - self.player.walkSpeed * dt
	elseif love.keyboard.isDown('down') then
		self.player.direction = 'down'
		self.player:changeAnimation('walk-down')
		self.player.y = self.player.y + self.player.walkSpeed * dt
	else
		self.player:changeState('idle')
	end
end


function PlayerMovingState:render()
	local anim = self.player.currentAnimation
	love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
		self.player.x, self.player.y)
end