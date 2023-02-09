LevelMaker = Class{}

function LevelMaker.createMap()
	local bricks = {}
	local brick_quads = GenerateBrickQuads(gTextures['main'])
	local w, h = brick_quads[0]:getQuadDimensions()
	local numRows = math.random(4, 7)
	local numCols = math.random(3, 6)*2 + 1
	for j = 0, numRows - 1 do
		brick_row = {}
		local color1 = math.random(0, 4) * 4
		local color2 = math.random(0, 4) * 4
		local color = color1
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
						else
							color = color1
						end
					end
					brick_row[i] = Brick(brick_quads[color].quad, w, h, x, h*j + 16)
				end
			else
				if noUnpairBrick == false then
					if doubleColor then
						if color == color1 then
							color = color2
						else
							color = color1
						end
					end
					brick_row[i] = Brick(brick_quads[color].quad, w, h, x, h*j + 16)
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