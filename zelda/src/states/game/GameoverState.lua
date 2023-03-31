GameoverState = Class{__includes = BaseState}

function GameoverState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('start')
    end

    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
end

function GameoverState:render()
    love.graphics.setFont(gFonts['zelda'])
    love.graphics.setColor(175/255, 53/255, 42/255, 1)
    love.graphics.printf('Game oveR', 0, VIRTUAL_HEIGHT / 2 - 48, VIRTUAL_WIDTH, 'center')
    
    love.graphics.setFont(gFonts['zelda-small'])
    love.graphics.printf('Press enteR', 0, VIRTUAL_HEIGHT / 2 + 16, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(1, 1, 1, 1)
end