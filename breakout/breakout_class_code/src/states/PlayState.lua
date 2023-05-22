--[[
    GD50
    Breakout Remake

    -- PlayState Class --

    Author: Colton Ogden
    cogden@cs50.harvard.edu

    Represents the state of the game in which we are actively playing;
    player should control the paddle, with the ball actively bouncing between
    the bricks, walls, and the paddle. If the ball goes below the paddle, then
    the player should lose one point of health and be taken either to the Game
    Over screen if at 0 health or the Serve screen otherwise.
]]

PlayState = Class{__includes = BaseState}

--[[
    We initialize what's in our PlayState via a state table that we pass between
    states as we go from playing to serving.
]]
function PlayState:enter(params)
    self.paddle = params.paddle
    self.bricks = params.bricks
    self.health = params.health
    self.score = params.score
    self.highScores = params.highScores
    
    self.balls = {}
    table.insert(self.balls, 1, params.ball)
    -- give ball random starting velocity
    self.balls[1].dx = math.random(-200, 200)
    self.balls[1].dy = math.random(-50, -60)

    self.powerUps = {}
    self.powerUpInterval = 5
    self.powerUpTimer = 0
    self.level = params.level

    self.hasLockedBlock = self:checkLockedBlock()

    self.recoverPoints = params.recoverPoints

    self.pointGained = 0

end

function PlayState:update(dt)
    if self.paused then
        if love.keyboard.wasPressed('space') then
            self.paused = false
            gSounds['pause']:play()
        else
            return
        end
    elseif love.keyboard.wasPressed('space') then
        self.paused = true
        gSounds['pause']:play()
        return
    end

    self.powerUpTimer = self.powerUpTimer + dt
    if self.powerUpTimer > self.powerUpInterval then
        self.powerUpTimer = self.powerUpTimer - self.powerUpInterval
        self.powerUpInterval = math.random(7, 30)
        self.hasLockedBlock = self:checkLockedBlock()
        if self.hasLockedBlock and not self.paddle.hasKey then
            key = PowerUp(10)
            key.x = math.random(20, VIRTUAL_WIDTH - 20)
            key.dy = 80
            table.insert(self.powerUps, key)
        end
        powerUp = PowerUp(2)
        powerUp.x = math.random(20, VIRTUAL_WIDTH - 20)
        table.insert(self.powerUps, powerUp)
    end

    -- update positions based on velocity
    self.paddle:update(dt)

    for i, pu in pairs(self.powerUps) do
        pu:update(dt)
        if pu:collides(self.paddle) then
            if pu.skin == 10 then
                self.paddle.hasKey = true
            else
                self:generate2Balls(pu)            
                gSounds['duplicate-ball']:play()
            end
        end
    end

     -- delete expired powerups
    for i, pu in pairs(self.powerUps) do
        if pu.remove then
            table.remove(self.powerUps, i)
        end
    end
    
    for i, ball in pairs(self.balls) do
        ball:update(dt)

        if ball:collides(self.paddle) then
            -- raise ball above paddle in case it goes below it, then reverse dy
            ball.y = self.paddle.y - 8
            ball.dy = -ball.dy

            --
            -- tweak angle of bounce based on where it hits the paddle
            --

            -- if we hit the paddle on its left side while moving left...
            if ball.x < self.paddle.x + (self.paddle.width / 2) and self.paddle.dx < 0 then
                ball.dx = -50 + -(8 * (self.paddle.x + self.paddle.width / 2 - ball.x))
            
            -- else if we hit the paddle on its right side while moving right...
            elseif ball.x > self.paddle.x + (self.paddle.width / 2) and self.paddle.dx > 0 then
                ball.dx = 50 + (8 * math.abs(self.paddle.x + self.paddle.width / 2 - ball.x))
            end

            gSounds['paddle-hit']:play()
        end

        -- detect collision across all bricks with the ball
        for k, brick in pairs(self.bricks) do

            -- only check collision if we're in play
            if brick.inPlay and ball:collides(brick) then

                -- trigger the brick's hit function, which removes it from play
                local score = brick:hit(self.paddle)
                -- add to score
                self.score = self.score + score
                self.pointGained = self.pointGained + score
                

                -- if we have enough points, recover a point of health
                if self.score > self.recoverPoints then
                    -- can't go above 3 health
                    self.health = math.min(3, self.health + 1)

                    -- multiply recover points by 2
                    self.recoverPoints = self.recoverPoints + math.min(100000, self.recoverPoints * 2)

                    -- play recover sound effect
                    gSounds['recover']:play()
                end

                if self.pointGained > 3000 then
                    self.pointGained = self.pointGained - 3000
                    self.paddle:increaseSize()
                end

                -- go to our victory screen if there are no more bricks left
                if self:checkVictory() then
                    gSounds['victory']:play()

                    gStateMachine:change('victory', {
                        level = self.level,
                        paddle = self.paddle,
                        health = self.health,
                        score = self.score,
                        highScores = self.highScores,
                        ball = ball, --is it gonna work once the old level is deleted?
                        recoverPoints = self.recoverPoints
                    })
                end

                --
                -- collision code for bricks
                --
                -- we check to see if the opposite side of our velocity is outside of the brick;
                -- if it is, we trigger a collision on that side. else we're within the X + width of
                -- the brick and should check to see if the top or bottom edge is outside of the brick,
                -- colliding on the top or bottom accordingly 
                --

                -- left edge; only check if we're moving right, and offset the check by a couple of pixels
                -- so that flush corner hits register as Y flips, not X flips
                if ball.x + 2 < brick.x and ball.dx > 0 then
                    
                    -- flip x velocity and reset position outside of brick
                    ball.dx = -ball.dx
                    ball.x = brick.x - 8
                
                -- right edge; only check if we're moving left, , and offset the check by a couple of pixels
                -- so that flush corner hits register as Y flips, not X flips
                elseif ball.x + 6 > brick.x + brick.width and ball.dx < 0 then
                    
                    -- flip x velocity and reset position outside of brick
                    ball.dx = -ball.dx
                    ball.x = brick.x + 32
                
                -- top edge if no X collisions, always check
                elseif ball.y < brick.y then
                    
                    -- flip y velocity and reset position outside of brick
                    ball.dy = -ball.dy
                    ball.y = brick.y - 8
                
                -- bottom edge if no X collisions or top collision, last possibility
                else
                    
                    -- flip y velocity and reset position outside of brick
                    ball.dy = -ball.dy
                    ball.y = brick.y + 16
                end

                -- slightly scale the y velocity to speed up the game, capping at +- 150
                if math.abs(ball.dy) < 150 then
                    ball.dy = ball.dy * 1.02
                end

                -- only allow colliding with one brick, for corners
                break
            end
        end

        if ball.y >= VIRTUAL_HEIGHT then
            ball.remove = true
            gSounds['hurt']:play()
        end

    end

    -- delete lost balls
    for b, ball in pairs(self.balls) do
        if ball.remove then
            table.remove(self.balls, b)
        end
    end

    -- if ball goes below bounds, revert to serve state and decrease health
    if #self.balls == 0 then

        self.health = self.health - 1
        self.paddle:reduceSize()


        if self.health == 0 then
            gStateMachine:change('game-over', {
                score = self.score,
                highScores = self.highScores
            })
        else
            gStateMachine:change('serve', {
                paddle = self.paddle,
                bricks = self.bricks,
                health = self.health,
                score = self.score,
                highScores = self.highScores,
                level = self.level,
                recoverPoints = self.recoverPoints
            })
        end
    end

    -- for rendering particle systems
    for k, brick in pairs(self.bricks) do
        brick:update(dt)
    end

    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
end

function PlayState:render()
    -- render bricks
    for k, brick in pairs(self.bricks) do
        brick:render()
    end

    -- render all particle systems
    for k, brick in pairs(self.bricks) do
        brick:renderParticles()
    end

    self.paddle:render()
    for i, ball in pairs(self.balls) do
        ball:render()
    end

    for i, pu in pairs(self.powerUps) do
        pu:render()
    end

    renderScore(self.score)
    renderHealth(self.health)
    if self.paddle.hasKey then
        renderKey()
    end


    -- pause text, if paused
    if self.paused then
        love.graphics.setFont(gFonts['large'])
        love.graphics.printf("PAUSED", 0, VIRTUAL_HEIGHT / 2 - 16, VIRTUAL_WIDTH, 'center')
    end
end

function PlayState:generate2Balls(powerUp)
        ball1 = Ball()
        ball1.skin = math.random(7)
        ball1.dx = math.random(-200, 200)
        ball1.dy = math.random(-50, -60)
        ball1.x = powerUp.x + powerUp.width/2 - ball1.width
        ball1.y = powerUp.y + powerUp.height - ball1.height
        table.insert(self.balls, ball1)

        ball2 = Ball()
        ball2.skin = math.random(7)
        ball2.dx = -ball1.dx
        ball2.dy = math.random(-50, -60)
        ball2.x = powerUp.x + powerUp.width/2
        ball2.y = powerUp.y + powerUp.height - ball2.height
        table.insert(self.balls, ball2)
end

function PlayState:checkVictory()
    for k, brick in pairs(self.bricks) do
        if brick.inPlay then
            return false
        end 
    end

    return true
end

function PlayState:checkLockedBlock()
    for k, brick in pairs(self.bricks) do
        if brick.locked then
            return true
        end 
    end

    return false
end

function renderKey()
    love.graphics.draw(gTextures['main'], gFrames['powerups'][10], VIRTUAL_WIDTH - 20, 20)
end
