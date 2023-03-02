Entity = Class{}

function Entity:init(def)
	self.x = def.x
	self.y = def.y
	self.width = def.width
	self.height = def.height
	self.dx = def.dx
	self.dy = def.dy
	self.direction = def.direction

	--pass code of the texture and not texture itself otherwis it will reinstantiate lots of texture, no notion of passing for reference?
	self.texture = def.texture
	self.currentAnimation = nil
	self.stateMachine = def.stateMachine

	self.level = def.level
end

function Entity:changeState(state, params)
	self.stateMachine:change(state, params)
end

function Entity:update(dt)
	self.stateMachine:update(dt)
	self.currentAnimation:update(dt)
end

--add collides

function Entity:render()
	xMirroring = self.direction == 'right' and 1 or -1
	love.graphics.draw(gTexture[self.texture], gFrames[self.texture][self.currentAnimation:getCurrentFrame()],
	math.floor(self.x) + self.width/2, math.floor(self.y) + self.height/2, 0, xMirroring, 1, self.width/2, self.height/2)
end


