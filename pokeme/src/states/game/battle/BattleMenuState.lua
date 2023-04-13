BattleMenuState = Class{__includes = BaseState}

function BattleMenuState:init(battleState)
    self.battleState = battleState
	self.menu = Menu({
    	x = VIRTUAL_WIDTH - 60,
    	y = VIRTUAL_HEIGHT - 64,
    	width = 60,
    	height = 64,
    	font = gFonts['medium'],
    	items = {
    		{
    			text = 'Fight',
    			callback = function()
    				gStateStack:pop()
    				gStateStack:push(FightState(self.battleState))
    			end
    		},
    		{
    			text = 'Items',
    			callback = function()
    				print(2) end
    		},
    		{
    			text = 'Run',
    			callback = function()
    				gStateStack:push(FadeState(
						{ r = 1, g = 1, b = 1, a = 0},
						{ r = 1, g = 1, b = 1, a = 1},
						0.5, 
						function()
							gStateStack:pop()
							gStateStack:pop()
							gStateStack:push(FadeState(
								{ r = 1, g = 1, b = 1, a = 1},
								{ r = 1, g = 1, b = 1, a = 0},
								0.5, 
								function() end))
						end))
    			end
    		}
    	}
    })
end

function BattleMenuState:update(dt)
	self.menu:update(dt)
end

function BattleMenuState:render()
	self.menu:render()
end

function BattleMenuState:printName()
	print('BattleMenuState')
end