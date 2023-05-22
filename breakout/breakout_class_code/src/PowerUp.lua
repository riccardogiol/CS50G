PowerUp = Class{}

function PowerUp:init(skin)
    self.x = 0
    self.y = 0
    self.width = 16
    self.height = 16

    self.dy = 50

    self.skin = skin
    self.remove = false
end

--[[
    Expects an argument with a bounding box, a paddle,
    and returns true if the bounding boxes of this and the argument overlap.
]]
function PowerUp:collides(paddle)
    if self.x > paddle.x + paddle.width or paddle.x > self.x + self.width then
        return false
    end

    if self.y > paddle.y + paddle.height or paddle.y > self.y + self.height then
        return false
    end 

    self.remove = true
    return true
end

function PowerUp:update(dt)
    self.y = self.y + self.dy * dt

    if self.y > VIRTUAL_HEIGHT then
        self.remove = true
    end
end

function PowerUp:render()
    love.graphics.draw(gTextures['main'], gFrames['powerups'][self.skin], self.x, self.y)
end