ReshuffleState = Class{__includes = BaseState}

function ReshuffleState:init()
    
    -- start our transition alpha at full, so we fade in
    self.transitionAlpha = 1

    -- start our level # label off-screen
    self.reshuffleLabelY = -64
end

function ReshuffleState:enter(def)
    
    -- params to pass by
    self.level = def.level
    self.board = def.board
    self.score = def.score
    self.timer = def.timer

    Timer.tween(1, {
        [self] = {transitionAlpha = 0}
    })
    :finish(function()
        Timer.tween(0.25, {
            [self] = {reshuffleLabelY = VIRTUAL_HEIGHT / 2 - 8}
        })
        :finish(function()
            Timer.after(1, function()
                
                Timer.tween(0.25, {
                    [self] = {reshuffleLabelY = VIRTUAL_HEIGHT + 30}
                })
                :finish(function()
                    gStateMachine:change('play', {
                        level = self.level,
                        board = Board(self.level, VIRTUAL_WIDTH - 272, 16),
                        score = self.score,
                        timer = self.timer
                    })
                end)
            end)
        end)
    end)
end

function ReshuffleState:update(dt)
    Timer.update(dt)
end

function ReshuffleState:render()
    self.board:render()

    love.graphics.setColor(95/255, 205/255, 228/255, 200/255)
    love.graphics.rectangle('fill', 0, self.reshuffleLabelY - 8, VIRTUAL_WIDTH, 48)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setFont(gFonts['large'])
    love.graphics.printf('Reshuffle!', 0, self.reshuffleLabelY, VIRTUAL_WIDTH, 'center')

    love.graphics.setColor(1, 1, 1, self.transitionAlpha)
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
end