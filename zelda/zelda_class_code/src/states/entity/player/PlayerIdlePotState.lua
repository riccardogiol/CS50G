PlayerIdlePotState = Class{__includes = EntityIdleState}

function PlayerIdlePotState:init(player, dungeon)
    self.entity = player
    self.dungeon = dungeon

    self.entity:changeAnimation('idle-pot-' .. self.entity.direction)

    self.entity.offsetY = 5
    self.entity.offsetX = 0
end

function PlayerIdlePotState:update(dt)
    if love.keyboard.isDown('left') or love.keyboard.isDown('right') or
       love.keyboard.isDown('up') or love.keyboard.isDown('down') then
        self.entity:changeState('walk-pot')
    end

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        self.dungeon.currentRoom:throwPot(self.entity.x - self.entity.offsetX, self.entity.y - self.entity.offsetY, self.entity.direction )
        self.entity:changeState('idle')
    end
end

function PlayerIdlePotState:render()
    local anim = self.entity.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.entity.x - self.entity.offsetX), math.floor(self.entity.y - self.entity.offsetY))
    love.graphics.draw(gTextures['tiles'], gFrames['tiles'][16],
        math.floor(self.entity.x - self.entity.offsetX), math.floor(self.entity.y - self.entity.offsetY) - 3)
end