QuadSpec = Class{}

function QuadSpec:init(quad, width, height)
	self.quad = quad
	self.width = width 
	self.height = height
end

function QuadSpec:getQuadDimensions()
	return self.width, self.height
end

function GeneratePaddleQuads(atlas)
	local y = 64
	local quads = {}
	local paddleHeigh = 16

	for i = 0, 3 do
		quads[i]={}
		quads[i][0] = QuadSpec(love.graphics.newQuad(0, y, 32, paddleHeigh, atlas:getDimensions()), 32, paddleHeigh)
		quads[i][1] = QuadSpec(love.graphics.newQuad(32, y, 64, paddleHeigh, atlas:getDimensions()), 64, paddleHeigh)
		quads[i][2] = QuadSpec(love.graphics.newQuad(96, y, 96, paddleHeigh, atlas:getDimensions()), 96, paddleHeigh)
		quads[i][3] = QuadSpec(love.graphics.newQuad(0, y + paddleHeigh, 128, paddleHeigh, atlas:getDimensions()), 128, paddleHeigh)
		y = y + paddleHeigh * 2
	end
	return quads
end

function GenerateBallQuads(atlas)
	local x = 96
	local y = 48
	local ballDimension = 8
	local quads = {}

	for i = 0, 3 do
		quads[i] = QuadSpec(love.graphics.newQuad(x, y, ballDimension, ballDimension, atlas:getDimensions()), ballDimension, ballDimension)
		x = x + ballDimension
	end
	x = 96
	y = y + ballDimension
	for i = 4, 6 do
		quads[i] = QuadSpec(love.graphics.newQuad(x+ballDimension, y, ballDimension, ballDimension, atlas:getDimensions()), ballDimension, ballDimension)
		x = x + ballDimension
	end
	return quads
end

function GenerateBrickQuads(atlas)
	local width = 32
	local height = 16
	local quads = {}
	local count = 0

	for j = 0, 2 do
		for i = 0, 5 do
			quads[count] = QuadSpec(love.graphics.newQuad(i * width, j * height, width, height, atlas:getDimensions()), width, height)
			count = count + 1
		end
	end 
	for i = 0, 2 do
		quads[count] = QuadSpec(love.graphics.newQuad(i * width, 48, width, height, atlas:getDimensions()), width, height)
		count = count + 1
	end
	return quads
end