push = require 'push'

VIRTUAL_WIDTH = 640
VIRTUAL_HEIGHT = 360

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

DEGREES_TO_RADIANS = 0.0174532925199432957
RADIANS_TO_DEGREES = 57.295779513082320876

function love.load()
	math.randomseed(os.time())
	love.graphics.setDefaultFilter('nearest', 'nearest')

	push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
		fullscreen = false, 
		vsync = true,
		resizable = false
	})

	world = love.physics.newWorld(0, 300)

	boxBody = love.physics.newBody(world, VIRTUAL_WIDTH / 2, VIRTUAL_HEIGHT / 2, 'dynamic')
	boxShape = love.physics.newRectangleShape(10, 20)
	boxFixture = love.physics.newFixture(boxBody, boxShape, 200)
	boxFixture:setRestitution(0.5)

	groundBody = love.physics.newBody(world, VIRTUAL_WIDTH / 2, VIRTUAL_HEIGHT, 'static')
	groundShape = love.physics.newRectangleShape(VIRTUAL_WIDTH, 20)
	groundFixture = love.physics.newFixture(groundBody, groundShape)
	wallLeftBody = love.physics.newBody(world, 0, VIRTUAL_HEIGHT / 2, 'static')
	wallLeftShape = love.physics.newRectangleShape(20, VIRTUAL_HEIGHT)
	wallLeftFixture = love.physics.newFixture(wallLeftBody, wallLeftShape)
	wallRightBody = love.physics.newBody(world, VIRTUAL_WIDTH, VIRTUAL_HEIGHT / 2, 'static')
	wallRightShape = love.physics.newRectangleShape(20, VIRTUAL_HEIGHT)
	wallRightFixture = love.physics.newFixture(wallRightBody, wallRightShape)
	--groundFixture:setRestitution(0.5)

	rotatingBodies = {}
	rotatingFixtures = {}
	rotatingShape = love.physics.newRectangleShape(15, 60)

	for i = 1, 3 do
		rotatingBodies[i] = love.physics.newBody(world, VIRTUAL_WIDTH / 2 + (2 - i) * 150 , 4 * VIRTUAL_HEIGHT / 5, 'kinematic')
		rotatingFixtures[i] = love.physics.newFixture(rotatingBodies[i], rotatingShape)
		rotatingBodies[i]:setAngularVelocity(360 * DEGREES_TO_RADIANS)
	end

	fallingBallsBodies = {}
	fallingBallsFixtures = {}
	fallingBallsShape = love.physics.newCircleShape(6)

	for i = 1, 200 do
		local ledOff = math.random(3)
		fallingBallsBodies[i] = {
			body = love.physics.newBody(world, math.random(VIRTUAL_WIDTH), VIRTUAL_HEIGHT / 4, 'dynamic'),
			r = (math.random(200, 255) / 255) * (ledOff == 1 and 0 or 1),
        	g = (math.random(200, 255) / 255)  * (ledOff == 2 and 0 or 1),
        	b = (math.random(200, 255) / 255)  * (ledOff == 3 and 0 or 1)
        }
		fallingBallsFixtures[i] = love.physics.newFixture(fallingBallsBodies[i].body, fallingBallsShape)
		fallingBallsFixtures[i]:setRestitution(0.5)
	end

end

function love.keypressed(key)
	if key == 'space' then
		boxBody:setPosition(math.random(10, VIRTUAL_WIDTH - 10), 0)
	end
	if key == 'escape' then
		love.event.quit()
	end
end

function love.update(dt)
	world:update(dt)
end

function love.draw()
	push:start()

	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.polygon('fill', boxBody:getWorldPoints(boxShape:getPoints()))
	love.graphics.setColor(0.6, 0.6, 0.6, 1)
	love.graphics.polygon('fill', groundBody:getWorldPoints(groundShape:getPoints()))

	love.graphics.setColor(0.3, 0.3, 0.3, 1)
	for i, rf in pairs(rotatingFixtures) do
		local rb = rf:getBody()
		local rs = rf:getShape()
		love.graphics.polygon('fill', rb:getWorldPoints(rs:getPoints()))
	end

	for i, bf in pairs(fallingBallsFixtures) do
		local bb = bf:getBody()
		local bs = bf:getShape()
		love.graphics.setColor(fallingBallsBodies[i].r, fallingBallsBodies[i].g, fallingBallsBodies[i].b, 1)
		love.graphics.circle('fill', bb:getX(), bb:getY(), bs:getRadius())
	end

	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 2, 2)
	push:finish()
end