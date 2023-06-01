--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

Projectile = Class{}

function Projectile:init(x, y, dx, dy)
    self.x = x
    self.y = y
    self.dy = dy
    self.dx = dx
    self.startX = x
    self.startY = y
    self.width = TILE_SIZE
    self.height = TILE_SIZE
    self.destroyed = false

end

function Projectile:update(dt)
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt

    if (math.abs(self.x - self.startX) + math.abs(self.y - self.startY)) > 4 * TILE_SIZE then
        self:destroy()
        return
    end

    local bottomEdge = VIRTUAL_HEIGHT - (VIRTUAL_HEIGHT - MAP_HEIGHT * TILE_SIZE) + MAP_RENDER_OFFSET_Y - TILE_SIZE

    if (self.x - self.width / 2 <= MAP_RENDER_OFFSET_X + TILE_SIZE) or
        (self.x + self.width / 2 >= VIRTUAL_WIDTH - TILE_SIZE * 2) or
        (self.y <= MAP_RENDER_OFFSET_Y + TILE_SIZE - self.height / 2) or
        (self.y + self.height / 2 >= bottomEdge) then
        self:destroy()
        return
    end
end

function Projectile:destroy()
    gSounds['break-pot']:play()
    self.destroyed = true
end


function Projectile:collides(target)
    return not (self.x + self.width < target.x or self.x > target.x + target.width or
                self.y + self.height < target.y or self.y > target.y + target.height)
end

function Projectile:render(adjacentOffsetX, adjacentOffsetY)
    love.graphics.draw(gTextures['tiles'], gFrames['tiles'][16], self.x + adjacentOffsetX, self.y + adjacentOffsetY)
end