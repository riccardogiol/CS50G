BattleMenuState = Class{__includes = BaseState}

function BattleMenuState:init(def)
	self.menu = Menu({
    	x = VIRTUAL_WIDTH / 2 -30,
    	y = 150,
    	width = 60,
    	height = 30,
    	items = {
    		{
    			text = 'Fight',
    			callback = function()
    				print(1)
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
    				gStateStack:pop()
    				gStateStack:pop()
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