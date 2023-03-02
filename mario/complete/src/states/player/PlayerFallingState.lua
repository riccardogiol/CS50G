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

	if self.player.y > 5*TILE_SIZE - CHARACTER_HEIGHT then
		self.player.y = 5*TILE_SIZE - CHARACTER_HEIGHT
		self.player.dy = 0
		self.player:changeState('idle')
	end

end
