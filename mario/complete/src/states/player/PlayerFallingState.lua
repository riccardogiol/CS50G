PlayerFallingState = Class{__includes = BaseState}


function PlayerFallingState:init(player)
	self.player = player

	self.animation = Animation({
		frames = {3},
		interval = 1
	})

	self.player.currentAnimation = self.animation
end

function PlayerFallingState:update(dt)
	if love.keyboard.isDown('left') then
		self.player.dx = CHARACTER_SPEED
		self.player.x = self.player.x - self.player.dx * dt
		self.player.direction = 'left'
		self.player:leftCollision()
	elseif love.keyboard.isDown('right') then
		self.player.dx = CHARACTER_SPEED
		self.player.x = self.player.x + self.player.dx * dt
		self.player.direction = 'right'
		self.player:rightCollision()
	end

	self.player.dy = self.player.dy + GRAVITY * dt
	self.player.y = self.player.y + self.player.dy * dt

	if self.player:groundCollision() then
		self.player:changeState('idle')
	end

	for i, enemy in pairs(self.player.level.enemies) do
		if enemy.alive then
			if enemy:collides(self.player) then
				enemy:changeState('dead')
				self.player:changeState('jumping', {
					jumpSpeed = CHARACTER_JUMP/2
				})
			end
		end
	end

end
