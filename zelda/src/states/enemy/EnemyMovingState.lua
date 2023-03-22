EnemyMovingState = Class{__includes = BaseState}

function EnemyMovingState:init(enemy)
	self.enemy = enemy
	self.duration = 0
	self.timer = 0
end

function EnemyMovingState:enter(enterParams)
	self.enemy:changeAnimation('walk-' .. self.enemy.direction)
	self.duration = math.random(4)
	self.timer = 0
end

function EnemyMovingState:update(dt)
	self.timer = self.timer + dt
	if self.timer > self.duration then
		if math.random(3) == 1 then
			self.enemy:changeState('idle')
		else
			local newDir = DIRECTIONS[math.random(#DIRECTIONS)]
			self.enemy.direction = newDir
			self.enemy:changeState('moving')
		end
	end

	touchedWall = self.enemy:move(dt)
	if touchedWall then
		if self.enemy.direction == 'left' then
			self.enemy.direction = 'right'
			self.enemy:changeState('moving')
		elseif self.enemy.direction == 'right' then
			self.enemy.direction = 'left'
			self.enemy:changeState('moving')
		elseif self.enemy.direction == 'up' then
			self.enemy.direction = 'down'
			self.enemy:changeState('moving')
		elseif self.enemy.direction == 'down' then
			self.enemy.direction = 'up'
			self.enemy:changeState('moving')
		end
	end
end


function EnemyMovingState:render()
	local anim = self.enemy.currentAnimation
	love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
		(self.enemy.x - self.enemy.offsetX), (self.enemy.y - self.enemy.offsetY))
end