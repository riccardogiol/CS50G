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
			['jumping'] = function() return PlayerJumpingState(self.player) end
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

	--[[
	if love.keyboard.keypressed['space'] and currentCharacterState == 'standing' then
		currentCharacterState = 'jumping'
		characterDY = CHARACTER_JUMP
	end

	if love.keyboard.isDown('left') then
		characterX = characterX - CHARACTER_SPEED * dt
		characterDirection = 'left'
		currentCharacterAnimation = movingAnimation
	elseif love.keyboard.isDown('right') then
		characterX = characterX + CHARACTER_SPEED * dt
		characterDirection = 'right'
		currentCharacterAnimation = movingAnimation
	else
		currentCharacterAnimation = idleAnimation
	end

	if not (currentCharacterState == 'standing') then
		currentCharacterAnimation = jumpingAnimation
		characterDY = characterDY + GRAVITY * dt
		characterY = characterY + characterDY * dt
		if characterDY > 0 then
			if characterY > 5*TILE_SIZE - CHARACTER_HEIGHT then
				characterY = 5*TILE_SIZE - CHARACTER_HEIGHT
				characterDY = 0
				currentCharacterState = 'standing'
			else
				currentCharacterState = 'falling'
			end
		end
	end


	currentCharacterAnimation:update(dt)
	]]
	self.cameraScrollX = - (self.player.x - (VIRTUAL_WIDTH/2 - CHARACTER_WIDTH/2))

end

function PlayState:render()
	love.graphics.translate(math.floor(self.cameraScrollX), 0)

	love.graphics.clear(self.backgroundColor)


	self.level:render()

	self.player:render()

	--[[
	local xMirroring = characterDirection == 'right' and 1 or -1

	love.graphics.draw(gTexture['character'], characterQuads[currentCharacterAnimation:getCurrentFrame()],
		math.floor(characterX) + CHARACTER_WIDTH/2, math.floor(characterY) + CHARACTER_HEIGHT/2, 
		0, xMirroring, 1,
		CHARACTER_WIDTH/2, CHARACTER_HEIGHT/2)


	love.graphics.translate( - math.floor(self.cameraScrollX), 0)


	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.print(tostring(currentCharacterState), 2, 30)
	]]

end
