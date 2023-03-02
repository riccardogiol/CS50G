PlayerIdleState = Class{__includes = BaseState}


function PlayerIdleState:init(player)
	self.player = player

	self.animation = Animation({
		frames = {1},
		interval = 1
	})

	self.player.currentAnimation = self.animation
end

function PlayerIdleState:update(dt)
	if love.keyboard.keypressed['space'] then
		self.player:changeState('jumping')
	end

	if love.keyboard.isDown('left') or love.keyboard.isDown('right') then
		self.player.dx = CHARACTER_SPEED
		self.player:changeState('moving')
	end

end