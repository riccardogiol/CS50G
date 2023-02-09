Brick = Class{}

function Brick:init(quad, width, height, x, y, pos)
	self.quad = quad 
	self.width = width
	self.height = height
	self.x = x
	self.y = y
	self.inPlay = true
	self.score = 25
	self.posOnBrickTable = pos
end

function Brick:updatePosition(dt)
end


function Brick:hit()
	if self.posOnBrickTable <= 3 then
		self.inPlay = false
		return self.score 
	else
		self.posOnBrickTable = self.posOnBrickTable - 4
		self.quad = GenerateBrickQuads(gTextures['main'])[self.posOnBrickTable].quad
		self.score = self.score * 2
		return 0
	end
end


function Brick:render()
	if self.inPlay then
		love.graphics.draw(gTextures['main'], self.quad, self.x, self.y)
	end
end
