CountdownState = Class{__includes = BaseState}

countdown_time = 0.75

function CountdownState:init()
	self.count = 3
	self.timer = 0
end

function CountdownState:update(dt)
	--update images position 
	gBackground:updatePosition(dt)
	gForeground:updatePosition(dt)

	self.timer = self.timer + dt
	if self.timer > countdown_time then
		self.timer = self.timer % countdown_time
		self.count = self.count - 1
	end

	if self.count < 0 then
		gStateMachine:change('play')
	end
end

function CountdownState:render()
	gBackground:render()
	gForeground:render()
	love.graphics.setFont(bigFont)
	if self.count > 0 then
		love.graphics.printf(tostring(self.count), 0, virtual_height/2 - 16, virtual_width, 'center')
	else
		love.graphics.printf("Play!", 0, virtual_height/2 - 16, virtual_width, 'center')
	end
end
