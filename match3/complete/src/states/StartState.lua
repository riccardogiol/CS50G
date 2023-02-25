StartState = Class{__includes = BaseState}

function StartState:init() 
	self.highlight = 1
	self.titleAlpha = 1

	self.colors = {
		[0] = {1, 0, 1, 1},
		[1] = {0, 1, 1, 1},
		[2] = {1, 1, 0, 1},
		[3] = {0, 0, 1, 1}
	}

	self.colorTimer = Timer.every(0.5, function()
		local lastColor = self.colors[3]
		for i, c in pairs(self.colors) do
			local currentColor = c
			self.colors[i] = lastColor
			lastColor = currentColor
		end
	end)
end 

function StartState:update(dt)
	if love.keyboard.wasPressed('up') then
		self.highlight = 1
		gSounds['select']:play()
	elseif love.keyboard.wasPressed('down') then
	    self.highlight = 2
		gSounds['select']:play()
	end

	if (love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return')) then
		if self.highlight == 1 then
			gSounds['select']:play()

			Timer.tween(0.5, {
				[self] = {
					titleAlpha = 0
				}
			}):finish(function ()
				--self.colorTimer:remove()
				gStateMachine:change('TransitionState', {
					board = gLevelMaker:generateBoard(tileQuads, NUM_ROW, NUM_COL, TILE_SIZE, colors, 2),
					colors = colors,
					numSymbols = 2,
					score = 0,
					level = 1
				})		
			end)
		elseif self.highlight == 2 then
			love.event.quit()
		end
	end

	if love.keyboard.wasPressed('escape') then
		love.event.quit()
	end
end

function StartState:render() 

	love.graphics.setColor(1, 1, 1, self.titleAlpha/2)
	love.graphics.rectangle('fill', 60, 40, VIRTUAL_WIDTH - 120, VIRTUAL_HEIGHT - 80, 10)

	love.graphics.setFont(gFonts['large'])
	love.graphics.setColor(0, 0, 0, self.titleAlpha)
	love.graphics.printf('Match 3', 2, VIRTUAL_HEIGHT /2 - 18, VIRTUAL_WIDTH, 'center')

	love.graphics.setFont(gFonts['large'])
	self.colors[0][4] =  self.titleAlpha
	love.graphics.setColor(self.colors[0])
	love.graphics.printf('Match 3', 0, VIRTUAL_HEIGHT /2 - 20, VIRTUAL_WIDTH, 'center')

	love.graphics.setFont(gFonts['medium'])
	love.graphics.setColor(0, 0, 0, self.titleAlpha)
	love.graphics.printf('Start Play', 1, VIRTUAL_HEIGHT /2 + 16, VIRTUAL_WIDTH, 'center')
	if self.highlight == 1 then
		love.graphics.setColor(1, 1, 1, self.titleAlpha)
	else
		love.graphics.setColor(0.5, 0.5, 0.5, self.titleAlpha)
	end
	love.graphics.printf('Start Play', 0, VIRTUAL_HEIGHT /2 + 15, VIRTUAL_WIDTH, 'center')

	love.graphics.setFont(gFonts['medium'])
	love.graphics.setColor(0, 0, 0, self.titleAlpha)
	love.graphics.printf('Quit', 1, VIRTUAL_HEIGHT /2 + 31, VIRTUAL_WIDTH, 'center')
	if self.highlight == 2 then
		love.graphics.setColor(1, 1, 1, self.titleAlpha)
	else
		love.graphics.setColor(0.5, 0.5, 0.5, self.titleAlpha)
	end
	love.graphics.printf('Quit', 0, VIRTUAL_HEIGHT /2 + 30, VIRTUAL_WIDTH, 'center')
end 