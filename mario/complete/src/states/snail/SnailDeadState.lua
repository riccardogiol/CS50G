SnailDeadState = Class{__includes = BaseState}


function SnailDeadState:init(snail)
	self.snail = snail
	self.snail.alive = false

	self.animation = Animation({
		frames = {53},
		interval = 1
	})

	self.snail.currentAnimation = self.animation
end
