EntryState = Class{__includes = BaseState}

function EntryState:init() end 

function EntryState:enter(enterParams) 
	self.score = enterParams.score
	self.fstChar = 'A'
	self.sndChar = 'A'
	self.trdChar = 'A'
	self.highlightChar = 1
end 

function EntryState:update(dt)	
	if love.keyboard.wasPressed('left') then
		self.highlightChar = math.max(self.highlightChar - 1, 1)
	elseif love.keyboard.wasPressed('right') then
		self.highlightChar = math.min(self.highlightChar + 1, 3)
	end


	if love.keyboard.wasPressed('up') then
		if self.highlightChar == 1 then
			if (string.byte(self.fstChar) + 1) > 90 then
				self.fstChar = 'A'
			else
				self.fstChar = string.char(string.byte(self.fstChar) + 1)
			end
		elseif self.highlightChar == 2 then
			if (string.byte(self.sndChar) + 1) > 90 then
				self.sndChar = 'A'
			else
				self.sndChar = string.char(string.byte(self.sndChar) + 1)
			end
		elseif self.highlightChar == 3 then
			if (string.byte(self.trdChar) + 1) > 90 then
				self.trdChar = 'A'
			else
				self.trdChar = string.char(string.byte(self.trdChar) + 1)
			end
		end
	elseif love.keyboard.wasPressed('down') then
		if self.highlightChar == 1 then
			if (string.byte(self.fstChar) - 1) < 65 then
				self.fstChar = 'Z'
			else
				self.fstChar = string.char(string.byte(self.fstChar) - 1)
			end
		elseif self.highlightChar == 2 then
			if (string.byte(self.sndChar) - 1) < 65 then
				self.sndChar = 'Z'
			else
				self.sndChar = string.char(string.byte(self.sndChar) - 1)
			end
		elseif self.highlightChar == 3 then
			if (string.byte(self.trdChar) - 1) < 65 then
				self.trdChar = 'Z'
			else
				self.trdChar = string.char(string.byte(self.trdChar) - 1)
			end
		end
	end


	if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
		scores = loadHighScore()
		newScores = ""
		found = false
		for k, s in pairs(scores) do
			if s.score > self.score or found then
				newScores = newScores .. s.name .. "," .. tostring(s.score) .. "\n"
			else
				newScores = newScores .. self.fstChar .. self.sndChar .. self.trdChar .. "," .. tostring(self.score) .. "\n"
				found = true
			end
		end
		love.filesystem.setIdentity('breakout')
		local filename = "breakout.lst"
		love.filesystem.write(filename, newScores)

		gStateMachine:change('start')
	end

	if love.keyboard.wasPressed('escape') then
		love.event.quit()
	end
end

function EntryState:render() 
	
	love.graphics.setFont(gFonts['medium'])
	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.printf("Your score is " .. tostring(self.score), 0, VIRTUAL_HEIGHT /4, VIRTUAL_WIDTH, 'center')
	
	love.graphics.setFont(gFonts['large'])
	if self.highlightChar == 1 then
		love.graphics.setColor(1, 1, 1, 1)
	else 
		love.graphics.setColor(0.5, 0.5, 0.5, 1)
	end
	love.graphics.print(self.fstChar, VIRTUAL_WIDTH/2 - 40 , VIRTUAL_HEIGHT/2 - 10)
	if self.highlightChar == 2 then
		love.graphics.setColor(1, 1, 1, 1)
	else 
		love.graphics.setColor(0.5, 0.5, 0.5, 1)
	end
	love.graphics.print(self.sndChar, VIRTUAL_WIDTH/2, VIRTUAL_HEIGHT/2 - 10)
	if self.highlightChar == 3 then
		love.graphics.setColor(1, 1, 1, 1)
	else 
		love.graphics.setColor(0.5, 0.5, 0.5, 1)
	end
	love.graphics.print(self.trdChar, VIRTUAL_WIDTH/2 + 40, VIRTUAL_HEIGHT/2 - 10)

	love.graphics.setFont(gFonts['small'])
	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.printf("Press 'enter' to confirm the name and save your High Score!", 0, VIRTUAL_HEIGHT - 40 , VIRTUAL_WIDTH, 'center')
end 
function EntryState:exit() end 