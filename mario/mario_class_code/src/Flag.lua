Flag = Class{__includes = GameObject}

function Flag:init(def)
    GameObject.init(self, def)
    self.animation = Animation({
        frames = def.frames,
        interval = 0.5
    })
end

function Flag:update(dt)
    GameObject.update(self, dt)
    self.animation:update(dt)
end

function Flag:render()
    love.graphics.draw(gTextures[self.texture], gFrames[self.texture][self.animation:getCurrentFrame()], self.x, self.y, 0, -1, 1, 0, 0)
end