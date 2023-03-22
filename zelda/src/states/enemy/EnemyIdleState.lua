EnemyIdleState = Class{__includes = BaseState}

function EnemyIdleState:init(enemy)
	self.enemy = enemy
	self.duration = 0
	self.timer = 0
end

function EnemyIdleState:enter(enterParams)
	self.enemy:changeAnimation('idle-' .. self.enemy.direction)
	self.duration = math.random(2)
	self.timer = 0
end

function EnemyIdleState:update(dt)
	self.timer = self.timer + dt
	if self.timer > self.duration then
		if math.random(8) == 1 then
			self.enemy:changeState('idle')
		else
			local newDir = DIRECTIONS[math.random(#DIRECTIONS)]
			self.enemy.direction = newDir
			self.enemy:changeState('moving')
		end
	end
end


function EnemyIdleState:render()
	local anim = self.enemy.currentAnimation
	love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
		(self.enemy.x - self.enemy.offsetX), (self.enemy.y - self.enemy.offsetY) )
end