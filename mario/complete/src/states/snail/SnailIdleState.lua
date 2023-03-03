SnailIdleState = Class{__includes = BaseState}


function SnailIdleState:init(snail)
	self.snail = snail
	self.waitingTime = 1
	self.waitingTimer = 0

	self.animation = Animation({
		frames = {54},
		interval = 1
	})

	self.snail.currentAnimation = self.animation
end

function SnailIdleState:update(dt)
	if self.waitingTimer < self.waitingTime then
		self.waitingTimer = self.waitingTimer + dt
	else
		self.snail:changeState('moving')
	end
end
