Brick = Class{}

paletteColors = {
	['blue'] = {['r'] = 99, ['g'] = 155, ['b'] = 255},
	['green'] = {['r'] = 106, ['g'] = 190, ['b'] = 47},
	['red'] = {['r'] = 255, ['g'] = 80, ['b'] = 90},
	['purple'] = {['r'] = 190, ['g'] = 40, ['b'] = 190},
	['gold'] = {['r'] = 251, ['g'] = 242, ['b'] = 54}
}

colorsOnTable = {
	[0] = 'blue',
	[1] = 'green',
	[2] = 'red',
	[3] = 'purple',
	[4] = 'gold'
}

function Brick:init(quad, width, height, x, y, pos)
	self.quad = quad 
	self.width = width
	self.height = height
	self.x = x
	self.y = y
	self.inPlay = true
	self.score = 25
	self.posOnBrickTable = pos
	self.color = colorsOnTable[math.floor(self.posOnBrickTable/4)]

	self.particleSystem = love.graphics.newParticleSystem(gTextures['particle'], 16)
	self.particleSystem:setParticleLifetime(0.5, 1.5)
	self.particleSystem:setLinearAcceleration(-15, 0, 15, 80)
	self.particleSystem:setEmissionArea('normal', 10, 5)
end

function Brick:updateParticles(dt)
	self.particleSystem:update(dt)
end


function Brick:hit()
	self.particleSystem:setColors(
		paletteColors[self.color].r/255,
		paletteColors[self.color].g/255,
		paletteColors[self.color].b/255,
		1,
		paletteColors[self.color].r/255,
		paletteColors[self.color].g/255,
		paletteColors[self.color].b/255,
		0)
	self.particleSystem:emit(64)
	if self.posOnBrickTable <= 3 then
		self.inPlay = false
		return self.score 
	else
		self.posOnBrickTable = self.posOnBrickTable - 4
		self.color = colorsOnTable[math.floor(self.posOnBrickTable/4)]
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

function Brick:renderParticles()
	love.graphics.draw(self.particleSystem, self.x + 16, self.y + 8)
end

