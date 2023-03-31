Obstacle = Class{}

function Obstacle:init(world, type, x, y)
	self.world = world
	self.type = type
	self.body = love.physics.newBody(self.world, x, y, 'dynamic')
	if self.type == 'horizontal' then
		self.shape = love.physics.newRectangleShape(110, 35)
	else
		self.shape = love.physics.newRectangleShape(35, 110)
	end
	self.fixture = love.physics.newFixture(self.body, self.shape)
end

function Obstacle:render()
	if self.type == 'horizontal' then
		love.graphics.draw(gTextures['wood'], gFrames['wood'][self.type], self.body:getX(), self.body:getY(), self.body:getAngle(), 1, 1, 55, 17.5)
	else
		love.graphics.draw(gTextures['wood'], gFrames['wood'][self.type], self.body:getX(), self.body:getY(), self.body:getAngle(), 1, 1, 17.5, 55)
	end
end
