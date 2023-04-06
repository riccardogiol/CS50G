Level = Class{}

function Level:init()
	self.tileMap = TileMap(24, 14)
	self.tileMap:randomizeMap()

	self.player = Entity({
		mapX = 5,
		mapY = 5, 
		width = 16,
		height = 16,
		animations = {
			['idle-down'] = Animation({
				texture = 'entities',
				frames = {5},
				interval = 1,
				loop = false
			})
		}
	})
	self.player.stateMachine = StateMachine({
		['idle'] = function() return PlayerIdleState(self.player) end
	})
	self.player:changeState('idle')
end

function Level:update(dt)
	self.player:update(dt)
end

function Level:render()
	self.tileMap:render()
	self.player:render()
end
