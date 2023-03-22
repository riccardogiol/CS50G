Player = Class{__includes = Entity}

function Player:init(def)
	Entity.init(self, def)
	self.score = def.score or 0
end

function Player:update(dt)
	Entity.update(self, dt)
end

function Player:render()
	Entity.render(self)
end

function Player:collides(target)
	local selfY, selfHeight = self.y + self.height / 2, self.height - self.height / 2

    return not (self.x + self.width < target.x or self.x > target.x + target.width or
                selfY + selfHeight < target.y or selfY > target.y + target.height)
end

function Player:collidesOffset(offsetX, offsetY, target)
    local selfY, selfHeight = self.y + self.height / 2, self.height - self.height / 2

    return not (self.x + offsetX + self.width < target.x or self.x + offsetX > target.x + target.width or
                selfY + offsetY + selfHeight < target.y or selfY + offsetY > target.y + target.height)
end