LevelCompleteState = Class{__includes = BaseState}

function LevelCompleteState:init() end 

function LevelCompleteState:enter(enterParams) 
	self.paddle = enterParams.paddle
	self.lives = enterParams.lives
	self.score = enterParams.score
	self.level = enterParams.level
end 

function LevelCompleteState:update(dt)	
	if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
		gStateMachine:change('serve', {
			ball = LevelMaker.createBall(), 
			bricks = LevelMaker.createMap(), 
			paddle = self.paddle, 
			lives = self.lives,
			score = self.score,
			level = self.level + 1

		})
	end

	if love.keyboard.wasPressed('escape') then
		love.event.quit()
	end
end

function LevelCompleteState:render() 
	self.paddle:render()

	love.graphics.setFont(gFonts['large'])
	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.printf("Level " .. self.level .. " complete!", 0, VIRTUAL_HEIGHT /2 - 40, VIRTUAL_WIDTH, 'center')

	love.graphics.setFont(gFonts['medium'])
	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.printf("Your current score is " .. tostring(self.score), 0, VIRTUAL_HEIGHT /2, VIRTUAL_WIDTH, 'center')

	love.graphics.setFont(gFonts['medium'])
	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.printf("Serve prerssing 'enter'", 0, VIRTUAL_HEIGHT /2 + 20, VIRTUAL_WIDTH, 'center')
	renderHealth(self.lives, 3)
end 
function LevelCompleteState:exit() end 