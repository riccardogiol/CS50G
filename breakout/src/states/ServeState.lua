ServeState = Class{__includes = BaseState}

function ServeState:init() end 

function ServeState:enter(enterParams) 
	self.ball = LevelMaker.createBall()
	self.bricks = enterParams.bricks
	self.paddle = enterParams.paddle
	self.lives = enterParams.lives
	self.paddle.x = (VIRTUAL_WIDTH - self.paddle.width)/2
	self.score = enterParams.score
	self.level = enterParams.level
end 

function ServeState:update(dt)
	if love.keyboard.isDown('left') then
		self.paddle:updatePosition(dt, 'left')
	elseif love.keyboard.isDown('right') then
		self.paddle:updatePosition(dt, 'right')
	end

	self.ball.x = self.paddle.x + (self.paddle.width - self.ball.width)/2
	

	if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
		self.ball.dy = -100
		self.ball.y = self.ball.y - 1
		gStateMachine:change('play', {
			ball = self.ball,
			bricks = self.bricks,
			paddle = self.paddle,
			lives = self.lives,
			score = self.score,
			level = self.level
		})
	end

	for j, brick_row in pairs(self.bricks) do
		for i, brick in pairs(brick_row) do
			brick:updateParticles(dt)
		end
	end

	if love.keyboard.wasPressed('escape') then
		love.event.quit()
	end

end 
function ServeState:render() 
	self.paddle:render()
	self.ball:render()
	for j, brick_row in pairs(self.bricks) do
		for i, brick in pairs(brick_row) do
			if brick.inPlay then
				brick:render()
			end
			brick:renderParticles()
		end
	end
	love.graphics.setFont(gFonts['large'])
	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.printf("Level " .. tostring(self.level), 0, VIRTUAL_HEIGHT /2 - 20, VIRTUAL_WIDTH, 'center')
	love.graphics.setFont(gFonts['medium'])
	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.printf("Serve prerssing 'enter'", 0, VIRTUAL_HEIGHT /2 + 5, VIRTUAL_WIDTH, 'center')
	renderHealth(self.lives, 3)
	renderScore(self.score)
end 
function ServeState:exit() end 