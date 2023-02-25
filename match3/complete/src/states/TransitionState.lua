TransitionState = Class{__includes = BaseState}

function TransitionState:enter(enterParams)
	self.board = enterParams.board
	self.colors = enterParams.colors
	self.numSymbols = enterParams.numSymbols
	self.score = enterParams.score
	self.level = enterParams.level
	self.bannerY = -100
	self.bannerHeight = 100
end 

function TransitionState:update()
	Timer.tween(0.8, {
		[self] = {
			bannerY = VIRTUAL_HEIGHT/2 - 50
		}
	}):finish(function() 
		Timer.tween(2, {}):finish(function()
			Timer.tween(0.8, {
				[self] = {
					bannerY = VIRTUAL_HEIGHT
				}
			}):finish(function()
				gStateMachine:change('PlayState', {
					board = self.board,
					colors = self.colors,
					numSymbols = self.numSymbols
				})		
			end)
		end)
	end)

	
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
end 


function TransitionState:render()
	-- print board
	love.graphics.setColor(1, 1, 1, 1)
	for j, r in pairs(self.board) do
		for i, t in pairs(r) do
			if t.tile then
				t.tile:render(OFFSET_X, OFFSET_Y)
			end
		end
	end

	love.graphics.setColor(1, 1, 1, 0.5)
	love.graphics.rectangle('fill', 0, self.bannerY, VIRTUAL_WIDTH, self.bannerHeight)


	love.graphics.setFont(gFonts['large'])
	love.graphics.setColor(0, 0, 0, 1)
	love.graphics.printf("Level " .. tostring(self.level), 2, self.bannerY + 38, VIRTUAL_WIDTH, 'center')
	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.printf("Level " .. tostring(self.level), 0, self.bannerY + 36, VIRTUAL_WIDTH, 'center')

end 