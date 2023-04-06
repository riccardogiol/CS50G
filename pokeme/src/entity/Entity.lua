Entity = Class{}

function Entity:init(def)
	self.mapX = def.mapX
	self.mapY = def.mapY
	self.width = def.width
	self.height = def.height
	self.direction = def.direction or 'down'

	self.x = (self.mapX - 1) * TILE_SIZE + (TILE_SIZE/2) - (self.width/2)
	self.y = (self.mapY - 1) * TILE_SIZE + (TILE_SIZE/2) - (self.height)

	self.stateMachine = nil
	self.animations = def.animations
	--self.currentAnimation = self.animations[1]
end

function Entity:changeState(name, enterParams)
	self.stateMachine:change(name, enterParams)
end

function Entity:changeAnimation(name)
	self.currentAnimation = self.animations[name]
end

function Entity:update(dt)
	self.stateMachine:update(dt)
end

function Entity:render()
	self.stateMachine:render()
end