PlayState = Class{__includes = BaseState}

function PlayState:init()
	self.player = Player({
        x = VIRTUAL_WIDTH / 2 - 8,
        y = VIRTUAL_HEIGHT / 2 - 11,
        width = 16,
        height = 22,
        offsetY = 5,
        walkSpeed = ENTITY_DEFS['player'].walkSpeed,
        direction = 'right',
        health = 6,

		animations = ParseAnimations(ENTITY_DEFS['player'].animations)
	})

	self.dungeon = Dungeon(self.player)

	self.player.stateMachine = StateMachine({
		['idle'] = function() return PlayerIdleState(self.player) end,
		['moving'] = function() return PlayerMovingState(self.player, self.dungeon) end,
		['sword'] = function() return PlayerSwordState(self.player) end
	})

	self.player:changeState('idle')
end

function PlayState:update(dt)
	-- some debug
    if love.keyboard.wasPressed('p') then
        for name, def in pairs(self.player.animations) do
        	print(name .. " current frame " .. def.currentFrame)
        end
    end

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