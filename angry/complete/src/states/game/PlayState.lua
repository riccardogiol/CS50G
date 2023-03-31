PlayState = Class{__includes = BaseState}

function PlayState:init()
	self.background = Background()
	self.level = Level()

	self.levelTranslation = 0

end


function PlayState:update(dt)
    if love.keyboard.keypressed['escape'] then
        love.event.quit()
    end

    if love.keyboard.isDown('left') then
    	self.levelTranslation = self.levelTranslation + MAP_SCROLL_X_SPEED * dt
    	if self.levelTranslation > VIRTUAL_WIDTH then
    		self.levelTranslation = VIRTUAL_WIDTH
    	else
			self.background:update(dt)
		end
	elseif love.keyboard.isDown('right') then
    	self.levelTranslation = self.levelTranslation - MAP_SCROLL_X_SPEED * dt
    	if self.levelTranslation < - VIRTUAL_WIDTH then
    		self.levelTranslation = - VIRTUAL_WIDTH
    	else
			self.background:update(dt)
		end
	end
	self.level:update(dt)
end

function PlayState:render(dt)
	self.background:render()

	love.graphics.translate(math.floor(self.levelTranslation), 0)
	self.level:render()
	love.graphics.translate(math.floor(-self.levelTranslation), 0)
end