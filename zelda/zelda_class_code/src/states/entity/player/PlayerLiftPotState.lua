PlayerLiftPotState = Class{__includes = BaseState}

function PlayerLiftPotState:init(player, dungeon)
    self.player = player
    self.dungeon = dungeon

    -- render offset for spaced character sprite
    self.player.offsetY = 5
    self.player.offsetX = 0

    -- create hitbox based on where the player is and facing
    local direction = self.player.direction

    -- sword-left, sword-up, etc
    self.player:changeAnimation('lift-' .. self.player.direction)
end

function PlayerLiftPotState:enter(params)

    -- restart sword swing sound for rapid swinging
    gSounds['pick-pot']:play()

    self.potIndex = params.potIndex

    -- restart sword swing animation
    self.player.currentAnimation:refresh()
end

function PlayerLiftPotState:update(dt)

    -- if we've fully elapsed through one cycle of animation, change back to idle state
    if self.player.currentAnimation.timesPlayed > 0 then
        self.player.currentAnimation.timesPlayed = 0
        self.player:changeState('idle-pot')
    end
end

function PlayerLiftPotState:exit()
    table.remove(self.dungeon.currentRoom.objects, self.potIndex)
end

function PlayerLiftPotState:render()
    local anim = self.player.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.player.x - self.player.offsetX), math.floor(self.player.y - self.player.offsetY))
end