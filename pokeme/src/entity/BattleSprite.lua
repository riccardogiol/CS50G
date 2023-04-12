BattleSprite = Class{}

function BattleSprite:init(texture, x, y)
	self.texture = texture
	self.x = x
	self.y = y
end

function BattleSprite:render()
	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.draw(gTextures[self.texture], self.x, self.y)
end