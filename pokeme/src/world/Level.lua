Level = Class{}

function Level:init()
	self.tileMap = TileMap(24, 14)
	self.tileMap:randomizeMap()

	self.player = Entity({
		mapX = 5,
		mapY = 5, 
		width = 16,
		height = 16,
		animations = GenerateAnimations(PLAYER_ANIMATIONS)
	})
	self.player.stateMachine = StateMachine({
		['idle'] = function() return PlayerIdleState(self.player) end,
		['walk'] = function() return PlayerWalkState(self.player, self.tileMap) end
	})
	self.player:changeState('idle')
end

function Level:update(dt)
	self.player:update(dt)
end

function Level:render()
	self.tileMap:render()
	self.player:render()
	self.tileMap:renderForegroundObjects(self.player)
end
