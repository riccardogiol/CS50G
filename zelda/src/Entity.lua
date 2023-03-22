Entity = Class{}

function Entity:init(def)
	self.x = def.x
    self.y = def.y
    self.width = def.width
    self.height = def.height
    self.walkSpeed = def.walkSpeed

    self.offsetX = def.offsetX or 0
    self.offsetY = def.offsetY or 0
    
    self.health = def.health
    self.death = def.death or false

    self.direction = def.direction or 'down'
    self.animations = def.animations
    self.currentAnimation = nil
    self.stateMachine = def.stateMachine

    self.invulnerable = false
    self.invulnerableTimer = 0
    self.invulnerableDuration = 1.5
    self.flashTimer = 0
    self.flashDuration = 0.1
    self.flashState = false

end

function Entity:changeAnimation(name)
	self.currentAnimation = self.animations[name]
end

function Entity:changeState(name)
    self.stateMachine:change(name)
end

function Entity:update(dt)
	if self.invulnerable then
		self.invulnerableTimer = self.invulnerableTimer + dt
		self.flashTimer = self.flashTimer + dt
		if self.invulnerableTimer > self.invulnerableDuration then
			self.invulnerableTimer = 0
			self.invulnerable = false
			self.flashTimer = 0
			self.flashState = false
		elseif self.flashTimer > self.flashDuration then
			self.flashTimer = 0
			self.flashState = not self.flashState
		end
	end
	self.stateMachine:update(dt)
	self.currentAnimation:update(dt)
end

function Entity:render()
	if self.flashState then
		love.graphics.setColor(1, 1, 1, 0.3)
	end
    self.stateMachine:render()
    love.graphics.setColor(1, 1, 1, 1)

end

function Entity:move(dt)
	if self.direction == 'left' then
		if self.x > MAP_RENDER_OFFSET_X + TILE_SIZE then
			self.x = self.x - self.walkSpeed * dt
			return false
		else
			return true
		end
	elseif self.direction == 'right' then
		if self.x + self.width < MAP_RENDER_OFFSET_X + (MAP_WIDTH - 1) * TILE_SIZE then
			self.x = self.x + self.walkSpeed * dt
		return false
		else
			return true
		end
	elseif self.direction == 'up' then
		if self.y + self.height/2 > MAP_RENDER_OFFSET_Y + TILE_SIZE then
			self.y = self.y - self.walkSpeed * dt
		return false
		else
			return true
		end
	elseif self.direction == 'down' then
		if self.y + self.height < MAP_RENDER_OFFSET_Y + (MAP_HEIGHT - 1) * TILE_SIZE then
			self.y = self.y + self.walkSpeed * dt
		return false
		else
			return true
		end
	end
end

function Entity:collides(target)
    return not (self.x + self.width < target.x or self.x > target.x + target.width or
                self.y + self.height < target.y or self.y > target.y + target.height)
end

--[[
function Entity:collidesOffset(offsetX, offsetY, target)
    return not (self.x + offsetX + self.width < target.x or self.x + offsetX > target.x + target.width or
                self.y + offsetY + self.height < target.y or self.y + offsetY > target.y + target.height)
end]]

function Entity:hitBy(enemy)
	if not self.invulnerable then
	    self.health = self.health - 1
	    self.invulnerable = true
	end
end

function Entity:changeDirection()
	local directions = {'left', 'right', 'up', 'down'}
	if self.direction == 'left' then
		table.remove(directions, 1)
		self.direction = directions[math.random(#directions)]
	elseif self.direction == 'right' then
		table.remove(directions, 2)
		self.direction = directions[math.random(#directions)]
	elseif self.direction == 'up' then
		table.remove(directions, 3)
		self.direction = directions[math.random(#directions)]
	elseif self.direction == 'down' then
		table.remove(directions, 4)
		self.direction = directions[math.random(#directions)]
	end
end
 --[[
function Entity:changeDirection()
	local directions = {'left', 'right', 'up', 'down'}
	if self.direction == 'left' then
		table.remove(table, pos)
		self.direction = 'right'
	elseif self.direction == 'right' then
		self.direction = 'left'
	elseif self.direction == 'up' then
		self.direction = 'down'
	elseif self.direction == 'down' then
		self.direction = 'up'
	end
end

function Entity:moveOutfrom(target)
	if self.direction == 'left' then
		self.x = target.x - self.width - 2
	elseif self.direction == 'right' then
		self.x = target.x + target.width + 2
	elseif self.direction == 'up' then
		self.y = target.y - self.height - 2
	elseif self.direction == 'down' then
		self.y = target.y + target.height + 2
	end
end]]
