PlayerMovingState = Class{__includes = BaseState}


function PlayerMovingState:init(player)
	self.player = player

	self.animation = Animation({
		frames = {10, 11},
		interval = 0.2
	})

	self.player.currentAnimation = self.animation
end

function PlayerMovingState:update(dt)
	if love.keyboard.keypressed['space'] then
		self.player:changeState('jumping')
	elseif love.keyboard.isDown('left') then
		self.player.x = self.player.x - self.player.dx * dt
		self.player.direction = 'left'
	elseif love.keyboard.isDown('right') then
		self.player.x = self.player.x + self.player.dx * dt
		self.player.direction = 'right'
	else
		self.player:changeState('idle')
	end
end
