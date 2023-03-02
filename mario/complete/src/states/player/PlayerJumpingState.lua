PlayerJumpingState = Class{__includes = BaseState}


function PlayerJumpingState:init(player)
	self.player = player

	self.animation = Animation({
		frames = {3},
		interval = 1
	})

	self.player.currentAnimation = self.animation
end

function PlayerJumpingState:enter(enterParams)
	self.player.dy = CHARACTER_JUMP
end

function PlayerJumpingState:update(dt)
	if love.keyboard.isDown('left') then
		self.player.dx = CHARACTER_SPEED
		self.player.x = self.player.x - self.player.dx * dt
		self.player.direction = 'left'
	elseif love.keyboard.isDown('right') then
		self.player.dx = CHARACTER_SPEED
		self.player.x = self.player.x + self.player.dx * dt
		self.player.direction = 'right'
	end

	self.player.dy = self.player.dy + GRAVITY * dt
	self.player.y = self.player.y + self.player.dy * dt

	if self.player.dy > 0 then
		self.player:changeState('falling')
	end

end