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
		self.player:changeState('jumping', {
			jumpSpeed = CHARACTER_JUMP
		})
	elseif love.keyboard.isDown('left') then
		self.player.x = self.player.x - self.player.dx * dt
		self.player.direction = 'left'
		self.player:leftCollision()
		if not self.player:groundCollision() then
			self.player:changeState('falling')
		end
	elseif love.keyboard.isDown('right') then
		self.player.x = self.player.x + self.player.dx * dt
		self.player.direction = 'right'
		self.player:rightCollision()
		if not self.player:groundCollision() then
			self.player:changeState('falling')
		end
	else
		self.player.dx = 0
		self.player:changeState('idle')
	end

	for i, enemy in pairs(self.player.level.enemies) do
		if enemy.alive then
			if enemy:collides(self.player) then
				gStateMachine:change('start')
			end
		end
	end
end
