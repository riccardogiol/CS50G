Player = Class{__includes = Entity}

function Player:init(def)
	Entity.init(self, def)
end

function Player:update(dt)
	Entity.update(self, dt)
end

function Player:render()
	Entity.render(self)
end

function Player:rightCollision()
	local upperTile = self.level:tileFromPoint(self.x + self.width - 1, self.y + 1)
	local lowerTile = self.level:tileFromPoint(self.x + self.width - 1, self.y + self.height - 1)
	if upperTile:collides() or lowerTile:collides() then
		self.x = math.min(upperTile.x - self.width + 1, lowerTile.x - self.width + 1)
		return true
	end
	return false
end

function Player:leftCollision()
	local upperTile = self.level:tileFromPoint(self.x + 1, self.y + 1)
	local lowerTile = self.level:tileFromPoint(self.x + 1, self.y + self.height - 1)
	if upperTile:collides() or lowerTile:collides() then
		self.x = math.max(upperTile.x + upperTile.width - 1, lowerTile.x + lowerTile.width - 1)
		return true
	end
	return false
end

function Player:groundCollision()
	local leftTile = self.level:tileFromPoint(self.x + 3, self.y + self.height + 1)
	local rightTile = self.level:tileFromPoint(self.x + self.width - 3, self.y + self.height + 1)
	if leftTile:collides() or rightTile:collides() then
		self.y = math.min(leftTile.y - self.height, rightTile.y - self.height)
		self.dy = 0
		return true
	end
	return false
end

function Player:topCollision()
	local leftTile = self.level:tileFromPoint(self.x + 3, self.y - 1)
	local rightTile = self.level:tileFromPoint(self.x + self.width - 3, self.y - 1)
	if leftTile:collides() or rightTile:collides() then
		self.y = math.max(leftTile.y + leftTile.height, rightTile.y + rightTile.height)
		self.dy = 0
		return true
	end
	return false
end