SnailMovingState = Class{__includes = BaseState}


function SnailMovingState:init(snail)
	self.snail = snail
	self.movingTimer = 0

	self.animation = Animation({
		frames = {56, 55},
		interval = 0.3
	})
	self.snail.currentAnimation = self.animation

	self.snail.dx = 15

	self.snail.x = self.snail.x - 2
	local leftCollides = self.snail:leftCollision() 
	self.snail.x = self.snail.x + 2

	self.snail.x = self.snail.x + 2
	local rightCollides = self.snail:rightCollision() 
	self.snail.x = self.snail.x - 2

	if leftCollides then
		if rightCollides then
			self.snail:changeState('idle')
		end
		self.snail.direction = 'right'
	elseif rightCollides then
		self.snail.direction = 'left'
	else
		self.snail.direction = math.random(2) == 1 and 'right' or 'left'
	end

end

function SnailMovingState:update(dt)
	if self.movingTimer < 2 then
		self.movingTimer = self.movingTimer + dt
		if self.snail.direction ==  'left' then
			self.snail.x = self.snail.x - self.snail.dx * dt
			if self.snail:leftCollision() then
				self.snail:changeState('idle')
			elseif not self.snail:groundCollision() then
				self.snail.direction = 'right'
				self.snail.x = self.snail.x + 2 * self.snail.dx * dt
				self.movingTimer = self.movingTimer - 0.2
			end
		else
			self.snail.x = self.snail.x + self.snail.dx * dt
			if self.snail:rightCollision() then
				self.snail:changeState('idle')
			elseif not self.snail:groundCollision() then
				self.snail.direction = 'left'
				self.snail.x = self.snail.x - 2 * self.snail.dx * dt
				self.movingTimer = self.movingTimer - 0.2
			end
		end
	else
		self.snail:changeState('idle')
	end
end


