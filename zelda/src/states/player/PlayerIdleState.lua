PlayerIdleState = Class{__includes = BaseState}

function PlayerIdleState:init(player)
	self.player = player
end

function PlayerIdleState:enter(enterParams)
	self.player:changeAnimation('idle-' .. self.player.direction)
end

function PlayerIdleState:update(dt)
	if love.keyboard.isDown('left') or love.keyboard.isDown('right') or
		love.keyboard.isDown('up') or love.keyboard.isDown('down') then
		self.player:changeState('moving')
	end
end


function PlayerIdleState:render()
	local anim = self.player.currentAnimation
	love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
		(self.player.x - self.player.offsetX), (self.player.y - self.player.offsetY) )
end