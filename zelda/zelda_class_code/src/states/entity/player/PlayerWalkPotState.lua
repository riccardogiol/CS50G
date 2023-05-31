PlayerWalkPotState = Class{__includes = EntityWalkState}

function PlayerWalkPotState:init(player, dungeon)
    self.entity = player
    self.dungeon = dungeon

    -- render offset for spaced character sprite; negated in render function of state
    self.entity.offsetY = 5
    self.entity.offsetX = 0
end

function PlayerWalkPotState:update(dt)
    if love.keyboard.isDown('left') then
        self.entity.direction = 'left'
        self.entity:changeAnimation('walk-pot-left')
    elseif love.keyboard.isDown('right') then
        self.entity.direction = 'right'
        self.entity:changeAnimation('walk-pot-right')
    elseif love.keyboard.isDown('up') then
        self.entity.direction = 'up'
        self.entity:changeAnimation('walk-pot-up')
    elseif love.keyboard.isDown('down') then
        self.entity.direction = 'down'
        self.entity:changeAnimation('walk-pot-down')
    else
        self.entity:changeState('idle-pot')
    end


    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        --throw pot projectile
        self.entity:changeState('idle')
    end

    -- perform base collision detection against walls
    EntityWalkState.update(self, dt)

end

function PlayerWalkPotState:render()
    local anim = self.entity.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.entity.x - self.entity.offsetX), math.floor(self.entity.y - self.entity.offsetY))
    love.graphics.draw(gTextures['tiles'], gFrames['tiles'][16],
        math.floor(self.entity.x - self.entity.offsetX), math.floor(self.entity.y - self.entity.offsetY) - 3)
end