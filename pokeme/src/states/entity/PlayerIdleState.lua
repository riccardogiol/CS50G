PlayerIdleState = Class{__includes = BaseState}

function PlayerIdleState:init(player)
	self.player = player
	self.player:changeAnimation('idle-' .. self.player.direction)
end

function PlayerIdleState:update(dt)
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
	end
	self.player.currentAnimation:update(dt)
end

function PlayerIdleState:render() end
