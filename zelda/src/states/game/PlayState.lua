PlayState = Class{__includes = BaseState}

function PlayState:init()
	self.player = Player({
        x = VIRTUAL_WIDTH / 2 - 8,
        y = VIRTUAL_HEIGHT / 2 - 11,
        width = 16,
        height = 22,
        walkSpeed = ENTITY_DEFS['player'].walkSpeed,
        direction = 'right',
        health = 6,

		animations = ParseAnimations(ENTITY_DEFS['player'].animations)
	})

	self.dungeon = Dungeon(self.player)

	self.player.stateMachine = StateMachine({
		['idle'] = function() return PlayerIdleState(self.player) end,
		['moving'] = function() return PlayerMovingState(self.player) end
	})

	self.player:changeState('idle')
end

function PlayState:update(dt)
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
    self.dungeon:update(dt)
end


function PlayState:render()
	love.graphics.push()
	self.dungeon:render()
	love.graphics.pop()

end