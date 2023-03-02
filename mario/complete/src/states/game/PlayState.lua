PlayState = Class{__includes = BaseState}

function PlayState:init()
	-- prepare map

	self.backgroundColor = {math.random(), math.random(), math.random(), 1}

	self.level = Level(100, 20)

	-- prepare character

	self.player = Player({
		x = VIRTUAL_WIDTH/2 - CHARACTER_WIDTH/2,
		y = 5 * TILE_SIZE - CHARACTER_HEIGHT,
		width = CHARACTER_WIDTH,
		height = CHARACTER_HEIGHT,
		dx = 0,
		dy = 0,
		direction = 'right',
		texture = 'character',
		map = nil,
		level = self.level,
		stateMachine = StateMachine {
			['idle'] = function() return PlayerIdleState(self.player) end,
			['moving'] = function() return PlayerMovingState(self.player) end,
			['jumping'] = function() return PlayerJumpingState(self.player) end,
			['falling'] = function() return PlayerFallingState(self.player) end
		}
	})

	self.player:changeState('idle')

	self.cameraScrollX = 0

end


function PlayState:update(dt)
	if love.keyboard.keypressed['r'] then
		self.backgroundColor = {math.random(), math.random(), math.random(), 1}
		self.level:randomiseTiles()
	end

	self.player:update(dt)

	self.cameraScrollX = - (self.player.x - (VIRTUAL_WIDTH/2 - CHARACTER_WIDTH/2))

end

function PlayState:render()
	love.graphics.translate(math.floor(self.cameraScrollX), 0)

	love.graphics.clear(self.backgroundColor)
	self.level:render()

	self.player:render()

	love.graphics.translate( - math.floor(self.cameraScrollX), 0)

end
