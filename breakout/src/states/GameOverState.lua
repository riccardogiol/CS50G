GameOverState = Class{__includes = BaseState}

function GameOverState:init() end 

function GameOverState:enter(enterParams) 
	self.lives = enterParams.lives
	self.score = enterParams.score
	self.level = enterParams.level
	self.scores = loadHighScore()
	self.tenthScore = self.scores[10].score
end 

function GameOverState:update(dt)	
	if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
		if self.score > self.tenthScore then
			gStateMachine:change('entry', {
				score = self.score
			})
		else
			gStateMachine:change('start')
		end
	end

	if love.keyboard.wasPressed('escape') then
		love.event.quit()
	end
end

function GameOverState:render() 
	love.graphics.setFont(gFonts['large'])
	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.printf("GAME OVER", 0, VIRTUAL_HEIGHT /2 - 40, VIRTUAL_WIDTH, 'center')

	love.graphics.setFont(gFonts['medium'])
	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.printf("Level " .. tostring(self.level), 0, VIRTUAL_HEIGHT /2 , VIRTUAL_WIDTH, 'center')
	love.graphics.setFont(gFonts['medium'])
	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.printf("Your score is " .. tostring(self.score), 0, VIRTUAL_HEIGHT /2 + 20, VIRTUAL_WIDTH, 'center')
	renderHealth(self.lives, 3)
end 
function GameOverState:exit() end 