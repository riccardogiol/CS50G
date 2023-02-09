GameOverState = Class{__includes = BaseState}

function GameOverState:init() end 

function GameOverState:enter(enterParams) 
	self.ball = LevelMaker.createBall()
	self.bricks = enterParams.bricks
	self.paddle = enterParams.paddle
	self.lives = enterParams.lives
	self.score = enterParams.score
end 

function GameOverState:update(dt)	
	if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
		gStateMachine:change('start')
	end

	if love.keyboard.wasPressed('escape') then
		love.event.quit()
	end
end

function GameOverState:render() 
	self.paddle:render()
	for j, brick_row in pairs(self.bricks) do
		for i, brick in pairs(brick_row) do
			if brick.inPlay then
				brick:render()
			end
		end
	end
	love.graphics.setFont(gFonts['large'])
	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.printf("GAME OVER", 0, VIRTUAL_HEIGHT /2 - 30, VIRTUAL_WIDTH, 'center')

	love.graphics.setFont(gFonts['medium'])
	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.printf("Your score is " .. tostring(self.score), 0, VIRTUAL_HEIGHT /2 + 10, VIRTUAL_WIDTH, 'center')
	renderHealth(self.lives, 3)
end 
function GameOverState:exit() end 