Snail = Class{__includes = Entity}

function Snail:init(def)
	Entity.init(self, def)
	self.alive = true
end

function Snail:update(dt)
	Entity.update(self, dt)
end

function Snail:render()
	Entity.render(self)
end