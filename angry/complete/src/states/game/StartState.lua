StartState = Class{__includes = BaseState}

function StartState:init()
	self.world = love.physics.newWorld(0, 300)
	self.groundBody = love.physics.newBody(self.world, 0, VIRTUAL_HEIGHT, 'static')
	self.groundShape = love.physics.newEdgeShape(0, 0, VIRTUAL_WIDTH, 0)
	self.groundFixture = love.physics.newFixture(self.groundBody, self.groundShape)
	self.leftWallBody = love.physics.newBody(self.world, 0, 0, 'static')
	self.rightWallBody = love.physics.newBody(self.world, VIRTUAL_WIDTH, 0, 'static')
	self.wallShape = love.physics.newEdgeShape(0, 0, 0, VIRTUAL_HEIGHT)
	self.leftWallFixture = love.physics.newFixture(self.leftWallBody, self.wallShape)
	self.rightWallFixture = love.physics.newFixture(self.rightWallBody, self.wallShape)

	self.aliens = {}
	for i = 0, 100 do
		self.aliens[i] = Alien(self.world, 'square', math.random(20, VIRTUAL_WIDTH - 20), math.random(10, 50))
	end
end

function StartState:enter() end

function StartState:update(dt)
	self.world:update(dt)
    if love.keyboard.keypressed['escape'] then
        love.event.quit()
    end
end

function StartState:render()
	for i, a in pairs(self.aliens) do
		a:render()
	end

	love.graphics.setColor(64/255, 64/255, 64/255, 200/255)
    love.graphics.rectangle('fill', VIRTUAL_WIDTH / 2 - 164, VIRTUAL_HEIGHT / 2 - 40, 328, 108, 3)
    
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setFont(gFonts['huge'])
    love.graphics.printf('Angry ME', 0, VIRTUAL_HEIGHT / 2 - 40, VIRTUAL_WIDTH, 'center')
    
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setFont(gFonts['medium'])
    love.graphics.printf('Click to start!', 0, VIRTUAL_HEIGHT / 2 + 40, VIRTUAL_WIDTH, 'center')
end