StartState = Class{__includes = BaseState}

function StartState:init() 
	self.highlight = 1
end 

function StartState:update(dt)
	if love.keyboard.wasPressed('up') then
		self.highlight = 1
		gSounds['paddle-hit']:play()
	elseif love.keyboard.wasPressed('down') then
	    self.highlight = 2
		gSounds['paddle-hit']:play()
	end

	if (love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return')) then
		if self.highlight == 1 then
			gStateMachine:change('paddle')
		elseif self.highlight == 2 then
			gStateMachine:change('highscore')
		end
	end

	if love.keyboard.wasPressed('escape') then
		love.event.quit()
	end
end

function StartState:render() 
	love.graphics.setFont(gFonts['large'])
	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.printf('Breakout!', 0, VIRTUAL_HEIGHT /2 - 20, VIRTUAL_WIDTH, 'center')

	love.graphics.setFont(gFonts['medium'])
	if self.highlight == 1 then
		love.graphics.setColor(1, 1, 1, 1)
	else
		love.graphics.setColor(0.5, 0.5, 0.5, 1)
	end
	love.graphics.printf('Start Play', 0, VIRTUAL_HEIGHT /2 + 15, VIRTUAL_WIDTH, 'center')

	love.graphics.setFont(gFonts['medium'])
	if self.highlight == 2 then
		love.graphics.setColor(1, 1, 1, 1)
	else
		love.graphics.setColor(0.5, 0.5, 0.5, 1)
	end
	love.graphics.printf('Highscore', 0, VIRTUAL_HEIGHT /2 + 30, VIRTUAL_WIDTH, 'center')
end 