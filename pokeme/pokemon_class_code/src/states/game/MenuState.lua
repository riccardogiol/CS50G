--[[
    GD50
    Pokemon

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

MenuState = Class{__includes = BaseState}

function MenuState:init(items, onClose)
    self.onClose = onClose or function() end
    self.menu = Menu {
        x = VIRTUAL_WIDTH / 2 - 100,
        y = VIRTUAL_HEIGHT / 2 - 64,
        width = 200,
        height = 128,
        useSelector = false,
        items = items
    }
    self.menu.selection.items[1].onSelect = onClose
end

function MenuState:update(dt)
    self.menu:update(dt)
end

function MenuState:render()
    self.menu:render()
end