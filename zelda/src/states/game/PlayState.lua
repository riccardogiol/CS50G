PlayState = Class{__includes = BaseState}

function PlayState:init() 
	self.currentRoom = Room()
end

function PlayState:update(dt)
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
end


function PlayState:render()
	love.graphics.push()
	self.currentRoom:render()
	love.graphics.pop()

end