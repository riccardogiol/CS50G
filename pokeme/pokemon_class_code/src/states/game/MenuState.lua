--[[
    GD50
    Pokemon

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

MenuState = Class{__includes = BaseState}

function MenuState:init(msg, onClose)
    print(msg)
    self.onClose = onClose or function() end
    self.menu = Menu {
        x = VIRTUAL_WIDTH / 2 - 64,
        y = VIRTUAL_HEIGHT / 2 - 64,
        width = 128,
        height = 128,
        useSelector = false,
        items = {
            {
                text = "health",
                onSelect = self.onClose
            },
            {
                text = "attack",
                onSelect = function() end
            }
        }
    }
end

function MenuState:update(dt)
    self.menu:update(dt)
end

function MenuState:render()
    self.menu:render()
end