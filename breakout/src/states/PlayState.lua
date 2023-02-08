PlayState = Class{}

function PlayState:init()

	self.bricks = {}

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


	local brick_quads = GenerateBrickQuads(gTextures['main'])
	local brick_padding_L = 60
	local brick_padding_T = 30
	color = math.random(0, 20)
	w, h = brick_quads[color]:getQuadDimensions()
	for j = 0, 3 do
		brick_row = {}
		for i = 0, 4 do
			brick_row[i] = Brick(brick_quads[color].quad, w, h, brick_padding_L + w*i, brick_padding_T + h*j)
		end
		self.bricks[j] = brick_row
	end

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
	end
	for j = 0, 3 do
		for i = 0, 4 do
			if self.bricks[j][i].inPlay then
				if self.ball:collides(self.bricks[j][i]) then
					self.ball:updatePositionCollides(self.bricks[j][i])
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
	for j = 0, 3 do
		for i = 0, 4 do
			if self.bricks[j][i].inPlay then
				self.bricks[j][i]:render()
			end
		end
	end
end 
function PlayState:exit() end 