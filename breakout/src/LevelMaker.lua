LevelMaker = Class{}

function LevelMaker.createMap(level)
	local bricks = {}
	local brick_quads = GenerateBrickQuads(gTextures['main'])
	local w, h = brick_quads[0]:getQuadDimensions()
	local levelFactor = level/4
	local numRows = math.random(math.min(math.ceil(5*levelFactor), 5), math.min(math.ceil(7*levelFactor), 7))
	local numCols = math.random(math.min(math.ceil(4*levelFactor), 4), math.min(math.ceil(6*levelFactor), 6))*2 + 1
	for j = 0, numRows - 1 do
		brick_row = {}
		local strip1 = math.random(0, math.min(math.floor(3*levelFactor), 3))
		local strip2 = math.random(0, math.min(math.floor(3*levelFactor), 3))
		local color1 = math.random(0, math.min(math.floor(4*levelFactor), 4)) * 4 + strip1
		local color2 = math.random(0, math.min(math.floor(4*levelFactor), 4)) * 4 + strip2
		local color = color1
		local score = 25
		local score1 = score + strip1*5
		local score2 = score + strip2*5
		local doubleColor = math.random(0, 100) < 50
		local noBrick = math.random(0, 100)
		local noPairBrick = noBrick < 20
		local noUnpairBrick = noBrick > 80
		for i = 0, numCols - 1 do
			local x = (VIRTUAL_WIDTH/2 - ((w/2) * numCols)) + i*w
			if i%2 == 0 then
				if noPairBrick == false then
					if doubleColor then
						if color == color1 then
							color = color2
							score = score2
						else
							color = color1
							score = score1
						end
					end
					brick_row[i] = Brick(brick_quads[color].quad, w, h, x, h*j + 16, color, score)
				end
			else
				if noUnpairBrick == false then
					if doubleColor then
						if color == color1 then
							color = color2
							score = score2
						else
							color = color1
							score = score1
						end
					end
					brick_row[i] = Brick(brick_quads[color].quad, w, h, x, h*j + 16, color, score)
				end
			end
		end
		bricks[j] = brick_row
	end
	return bricks
end

function LevelMaker.createPaddle()
	local paddle_quads = GeneratePaddleQuads(gTextures['main'])
	local color = math.random(0, 3)
	local difficulty = 1
	local w, h = paddle_quads[color][difficulty]:getQuadDimensions()
	local paddle = Paddle(paddle_quads[color][difficulty].quad, w, h, (VIRTUAL_WIDTH - w)/2, VIRTUAL_HEIGHT - 32, 250)
	return paddle
end

function LevelMaker.createBall()
	local ball_quads = GenerateBallQuads(gTextures['main'])
	local color = math.random(0, 6)
	local w, h = ball_quads[color]:getQuadDimensions()
	local ball = Ball(ball_quads[color].quad, w, h, (VIRTUAL_WIDTH - w)/2, VIRTUAL_HEIGHT - 40, 0, 0)
	return ball
end