StartState = Class{__includes = BaseState}

function StartState:init()
    self.level = Level(100, 15)
    self.background = math.random(3)
end

function StartState:update(dt)
    if love.keyboard.keypressed['enter'] or love.keyboard.keypressed['return'] then
        gStateMachine:change('play')
    end
end

function StartState:render()
    love.graphics.draw(gTexture['backgrounds'], gFrames['background'][self.background], 0, 50)
    love.graphics.draw(gTexture['backgrounds'], gFrames['background'][self.background], 0, 0)
    self.level:render()

    love.graphics.setFont(gFont['large'])
    love.graphics.setColor(0, 0, 0, 255)
    love.graphics.printf('Super 50 Bros.', 1, VIRTUAL_HEIGHT / 2 - 40 + 1, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.printf('Super 50 Bros.', 0, VIRTUAL_HEIGHT / 2 - 40, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(gFont['medium'])
    love.graphics.setColor(0, 0, 0, 255)
    love.graphics.printf('Press Enter', 1, VIRTUAL_HEIGHT / 2 + 17, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.printf('Press Enter', 0, VIRTUAL_HEIGHT / 2 + 16, VIRTUAL_WIDTH, 'center')
end