EnemyIdleState = Class{__includes = BaseState}

function EnemyIdleState:init(enemy)
	self.enemy = enemy
end

function EnemyIdleState:enter(enterParams)
	self.enemy:changeAnimation('idle-' .. self.enemy.direction)
end

function EnemyIdleState:update(dt)
end


function EnemyIdleState:render()
	local anim = self.enemy.currentAnimation
	love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
		(self.enemy.x - self.enemy.offsetX), (self.enemy.y - self.enemy.offsetY) )
end