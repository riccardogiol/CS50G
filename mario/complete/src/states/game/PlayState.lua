PlayState = Class{__includes = BaseState}

function PlayState:init()
	-- prepare map
	self.background = math.random(3)
	self.backgroundX = 0

	self.mapWidth = 100

	self.level = Level(self.mapWidth, 15)

	-- prepare character

	self.player = Player({
		x = VIRTUAL_WIDTH/2 - CHARACTER_WIDTH/2,
		y = 5,
		width = CHARACTER_WIDTH,
		height = CHARACTER_HEIGHT,
		dx = 0,
		dy = 0,
		direction = 'right',
		texture = 'character',
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

function PlayState:enter(enterParams)
	self.player.score = enterParams.score
end


function PlayState:update(dt)
	self.player:update(dt)
	self.level:update(dt)
	self.cameraScrollX = math.min(math.max(self.player.x - (VIRTUAL_WIDTH/2 - CHARACTER_WIDTH/2), 0), self.mapWidth*TILE_SIZE - VIRTUAL_WIDTH)
	self.backgroundX = (self.cameraScrollX / 3) % 256
end

function PlayState:render()
	love.graphics.draw(gTexture['backgrounds'], gFrames['background'][self.background], math.floor(-self.backgroundX), 50)
	love.graphics.draw(gTexture['backgrounds'], gFrames['background'][self.background], math.floor(-self.backgroundX) + 256, 50)
	love.graphics.draw(gTexture['backgrounds'], gFrames['background'][self.background], math.floor(-self.backgroundX), 0)
	love.graphics.draw(gTexture['backgrounds'], gFrames['background'][self.background], math.floor(-self.backgroundX) + 256, 0)
	love.graphics.translate(math.floor(- self.cameraScrollX), 0)

	self.level:render()
	self.player:render()

	love.graphics.translate(math.floor(self.cameraScrollX), 0)

	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.setFont(gFont['small'])
	love.graphics.printf("Score: " .. tostring(self.player.score), 0, 3, VIRTUAL_WIDTH - 3, 'right')
end
