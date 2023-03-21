Object = Class{}

function Object:init(def, x, y, offsetX, offsetY)
    self.x = x
    self.y = y
    self.width = def.width
    self.height = def.height
    self.offsetX = offsetX or 0
    self.offsetY = offsetY or 0

    self.type = def.type
    self.texture = def.texture
    self.frame = def.frame or 1

    self.solid = def.solid

    self.defaultState = def.defaultState
    self.state = self.defaultState
    self.states = def.states

    self.onCollide = function() end
end

function Object:render()
    love.graphics.draw(gTextures[self.texture], gFrames[self.texture][self.states[self.state].frame or self.frame],
        self.offsetX + self.x, self.offsetY + self.y)
end