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
	self.player.dy = enterParams.jumpSpeed
end

function PlayerJumpingState:update(dt)
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

	if self.player:topCollision() then
		self.player:changeState('falling')
	else
		self.player.dy = self.player.dy + GRAVITY * dt
		self.player.y = self.player.y + self.player.dy * dt

		if self.player.dy > 0 then
			self.player:changeState('falling')
		end
	end

	for i, enemy in pairs(self.player.level.enemies) do
		if enemy.alive then
			if enemy:collides(self.player) then
				gStateMachine:change('start')
			end
		end
	end

	for i, block in pairs(self.player.level.blocks) do
		if block.solid then
			if block:collides(self.player) then
				mess = block:onCollide()
				if mess.nextLevel then 
					gStateMachine:change('play', {
						score = self.player.score
					})
				end
			end
		end
	end

end
