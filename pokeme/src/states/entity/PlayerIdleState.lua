PlayerIdleState = Class{__includes = BaseState}

function PlayerIdleState:init(player)
	self.player = player
	self.player:changeAnimation('idle-' .. self.player.direction)
end

function PlayerIdleState:update(dt)
	--commands
	self.player.currentAnimation:update(dt)
end

function PlayerIdleState:render()
	-- move this to general
	local anim = self.player.currentAnimation
	love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
		self.player.x, self.player.y)
end
