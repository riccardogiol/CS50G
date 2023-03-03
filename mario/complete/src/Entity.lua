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

function Entity:rightCollision()
	local upperTile = self.level:tileFromPoint(self.x + self.width - 1, self.y + 1)
	local lowerTile = self.level:tileFromPoint(self.x + self.width - 1, self.y + self.height - 1)
	if upperTile:collides() or lowerTile:collides() then
		self.x = math.min(upperTile.x - self.width + 1, lowerTile.x - self.width + 1)
		return true
	end
	return false
end

function Entity:leftCollision()
	local upperTile = self.level:tileFromPoint(self.x + 1, self.y + 1)
	local lowerTile = self.level:tileFromPoint(self.x + 1, self.y + self.height - 1)
	if upperTile:collides() or lowerTile:collides() then
		self.x = math.max(upperTile.x + upperTile.width - 1, lowerTile.x + lowerTile.width - 1)
		return true
	end
	return false
end

function Entity:groundCollision()
	local leftTile = self.level:tileFromPoint(self.x + 3, self.y + self.height + 1)
	local rightTile = self.level:tileFromPoint(self.x + self.width - 3, self.y + self.height + 1)
	if leftTile:collides() or rightTile:collides() then
		self.y = math.min(leftTile.y - self.height, rightTile.y - self.height)
		self.dy = 0
		return true
	end
	return false
end

function Entity:topCollision()
	local leftTile = self.level:tileFromPoint(self.x + 3, self.y - 1)
	local rightTile = self.level:tileFromPoint(self.x + self.width - 3, self.y - 1)
	if leftTile:collides() or rightTile:collides() then
		self.y = math.max(leftTile.y + leftTile.height, rightTile.y + rightTile.height)
		self.dy = 0
		return true
	end
	return false
end

