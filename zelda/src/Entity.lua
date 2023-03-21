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
    self.death = def.health

    self.direction = def.direction
    self.animations = def.animations
    self.currentAnimation = nil
    self.stateMachine = def.stateMachine

end

function Entity:changeAnimation(name)
	self.currentAnimation = self.animations[name]
end

function Entity:changeState(name)
    self.stateMachine:change(name)
end

function Entity:update(dt)
	self.stateMachine:update(dt)
	self.currentAnimation:update(dt)
end

function Entity:render()
    self.stateMachine:render()
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
