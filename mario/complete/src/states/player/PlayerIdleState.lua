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
	if not self.player:groundCollision() then
		self.player:changeState('falling')
	elseif love.keyboard.keypressed['space'] then
		self.player:changeState('jumping', {
			jumpSpeed = CHARACTER_JUMP
		})
	elseif love.keyboard.isDown('left') or love.keyboard.isDown('right') then
		self.player.dx = CHARACTER_SPEED
		self.player:changeState('moving')
	end

	for i, enemy in pairs(self.player.level.enemies) do
		if enemy.alive then
			if enemy:collides(self.player) then
				gStateMachine:change('start')
			end
		end
	end
end
