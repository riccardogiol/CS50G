PlayState = Class{__includes = BaseState}

function PlayState:init() end 

function PlayState:enter(enterParams)
	self.ball = enterParams.ball
	self.bricks = enterParams.bricks
	self.paddle = enterParams.paddle
	self.lives = enterParams.lives
	self.score = enterParams.score
end 

function PlayState:update(dt)
	if love.keyboard.isDown('left') then
		self.paddle:updatePosition(dt, 'left')
	elseif love.keyboard.isDown('right') then
		self.paddle:updatePosition(dt, 'right')
	end

	self.ball:updatePosition(dt)
	if self.ball:collides(self.paddle) then
		self.ball:updatePositionCollides(self.paddle)
		self.ball:updateSpeedPaddleCollision(self.paddle)
	end
	for j, brick_row in pairs(self.bricks) do
		for i, brick in pairs(brick_row) do
			if brick.inPlay then
				if self.ball:collides(brick) then
					self.ball:updatePositionCollides(brick)
					self.score = self.score + brick:hit()
				end
			end
			brick:updateParticles(dt)
		end
	end

	if self.ball.y > VIRTUAL_HEIGHT then
		self.lives = self.lives - 1
		if self.lives < 0 then
			gStateMachine:change('gameover', {
				paddle = self.paddle,
				ball = self.ball, 
				bricks = self.bricks, 
				lives = self.lives,
				score = self.score
			})
		else
			gStateMachine:change('serve', {
				paddle = self.paddle,
				ball = self.ball, 
				bricks = self.bricks, 
				lives = self.lives,
				score = self.score
			})
		end
	end

	if love.keyboard.wasPressed('escape') then
		love.event.quit()
	end

end 
function PlayState:render() 
	self.paddle:render()
	self.ball:render()
	for j, brick_row in pairs(self.bricks) do
		for i, brick in pairs(brick_row) do
			if brick.inPlay then
				brick:render()
			end
		end
	end
	for j, brick_row in pairs(self.bricks) do
		for i, brick in pairs(brick_row) do
			brick:renderParticles()
		end
	end
	renderHealth(self.lives, 3)
	renderScore(self.score)
end 
function PlayState:exit() end 