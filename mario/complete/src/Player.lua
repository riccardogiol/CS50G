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
	end
end

function Player:leftCollision()
	local upperTile = self.level:tileFromPoint(self.x + 1, self.y + 1)
	local lowerTile = self.level:tileFromPoint(self.x + 1, self.y + self.height - 1)
	if upperTile:collides() or lowerTile:collides() then
		self.x = math.min(upperTile.x + upperTile.width - 1, lowerTile.x + lowerTile.width - 1)
	end
end