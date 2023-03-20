Entity = Class{}

function Entity:init(def)
	self.x = def.x
    self.y = def.y
    self.width = def.width
    self.height = def.height
    self.walkSpeed = def.walkSpeed
    
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