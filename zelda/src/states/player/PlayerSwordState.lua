PlayerSwordState = Class{__includes = BaseState}

function PlayerSwordState:init(player)
	self.player = player

	self.player.offsetX = 7
	self.player.offsetY = 4

	self.player:changeAnimation('sword-' .. self.player.direction)

	local dir = self.player.direction
	local hitboxLong, hitboxLarge = 16, 8
	if dir == "left" then
		self.swordHitbox = Hitbox(self.player.x - hitboxLarge, self.player.y + 2, hitboxLarge, hitboxLong)
	elseif dir == "right" then
		self.player.offsetX = 5
		self.swordHitbox = Hitbox(self.player.x + self.player.width, self.player.y + 2, hitboxLarge, hitboxLong)
	elseif dir == "up" then
		self.player.offsetY = 8
		self.swordHitbox = Hitbox(self.player.x, self.player.y - hitboxLarge, hitboxLong, hitboxLarge)
	elseif dir == "down" then
		self.player.offsetY = 2
		self.swordHitbox = Hitbox(self.player.x, self.player.y + self.player.height, hitboxLong, hitboxLarge)
	end

end

function PlayerSwordState:enter(enterParams)
	self.player.currentAnimation:refresh()
	Event.dispatch("attack", self.swordHitbox)
end

function PlayerSwordState:update(dt)
	local currentFrame = self.player.currentAnimation.currentFrame
	if self.player.currentAnimation.loopExecuted then
		self.player:changeState('idle')
	end
end

function PlayerSwordState:exit()
	self.player.offsetX = 0
	self.player.offsetY = 5
end

function PlayerSwordState:render()
	local anim = self.player.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.player.x - self.player.offsetX), math.floor(self.player.y - self.player.offsetY))
    --love.graphics.setColor(1, 0, 1, 1)
    --love.graphics.rectangle('line', self.swordHitbox.x, self.swordHitbox.y, self.swordHitbox.width, self.swordHitbox.height)
end