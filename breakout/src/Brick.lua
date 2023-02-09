Brick = Class{}

function Brick:init(quad, width, height, x, y)
	self.quad = quad 
	self.width = width
	self.height = height
	self.x = x
	self.y = y
	self.inPlay = true
	self.score = 25
end

function Brick:updatePosition(dt)
end

function Brick:render()
	if self.inPlay then
		love.graphics.draw(gTextures['main'], self.quad, self.x, self.y)
	end
end
