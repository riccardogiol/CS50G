PlayState = Class{}

function PlayState:init()

	local paddle_quads = GeneratePaddleQuads(gTextures['main'])
	color = math.random(0, 3)
	difficulty = 1
	w, h = paddle_quads[color][difficulty]:getQuadDimensions()
	self.paddle = Paddle(paddle_quads[color][difficulty].quad, w, h, (VIRTUAL_WIDTH - w)/2, VIRTUAL_HEIGHT - 32, 250)
	
	local ball_quads = GenerateBallQuads(gTextures['main'])
	color = math.random(0, 6)
	w, h = ball_quads[color]:getQuadDimensions()
	dx = math.random(-200, 200)
	dy = math.random(-50, -60)
	self.ball = Ball(ball_quads[color].quad, w, h, (VIRTUAL_WIDTH - w)/2, VIRTUAL_HEIGHT - 41, dx, dy)

	self.bricks = LevelMaker.createMap()

end 

function PlayState:enter() end 

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
					self.bricks[j][i].inPlay = false
				end
			end
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
end 
function PlayState:exit() end 