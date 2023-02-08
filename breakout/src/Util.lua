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

	for i = 0, 3 do
		quads[i]={}
		quads[i][0] = QuadSpec(love.graphics.newQuad(0, y, 32, 16, atlas:getDimensions()), 32, 16)
		quads[i][1] = QuadSpec(love.graphics.newQuad(32, y, 64, 16, atlas:getDimensions()), 64, 16)
		quads[i][2] = QuadSpec(love.graphics.newQuad(96, y, 96, 16, atlas:getDimensions()), 96, 16)
		quads[i][3] = QuadSpec(love.graphics.newQuad(0, y + 16, 128, 16, atlas:getDimensions()), 128, 16)
		y = y + 32
	end
	return quads
end