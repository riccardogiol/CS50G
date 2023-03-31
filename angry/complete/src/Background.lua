Background = Class{}

function Background:init()
	self.image = 'colored-desert'
	self.width = gTextures[self.image]:getWidth()
	self.xOffset = 0
end

function Background:update(dt)
	if love.keyboard.isDown('left') then
		self.xOffset = self.xOffset + BACKGROUND_SCROLL_X_SPEED * dt
	elseif love.keyboard.isDown('right') then
		self.xOffset = self.xOffset - BACKGROUND_SCROLL_X_SPEED * dt
	end

	self.xOffset = self.xOffset % self.width
end

function Background:render()
	love.graphics.draw(gTextures[self.image], self.xOffset, -80)
	love.graphics.draw(gTextures[self.image], self.xOffset - self.width, -80)
	love.graphics.draw(gTextures[self.image], self.xOffset + self.width, -80)
end