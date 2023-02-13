PaddleState = Class{__includes = BaseState}

function PaddleState:init() end 

function PaddleState:enter(enterParams)
	self.paddle = LevelMaker.createPaddle()

	self.paddle.x = (VIRTUAL_WIDTH - self.paddle.width)/2
	self.paddle.y = 2*VIRTUAL_HEIGHT/3
	self.paddle_quads = GeneratePaddleQuads(gTextures['main'])
	self.padColor = math.random(0, 3)
	self.padDifficulty = 1
	self.paddle.quad = self.paddle_quads[self.padColor][self.padDifficulty].quad
end 

function PaddleState:update(dt)	
	if love.keyboard.wasPressed('left') then
		if self.padColor - 1 < 0 then
			self.padColor = 3
		else
			self.padColor = self.padColor - 1
		end
	elseif love.keyboard.wasPressed('right') then
		if self.padColor + 1 > 3 then
			self.padColor = 0
		else
			self.padColor = self.padColor + 1
		end
	end
	self.paddle.quad = self.paddle_quads[self.padColor][self.padDifficulty].quad


	if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
		self.paddle.y = VIRTUAL_HEIGHT - 32
		gStateMachine:change('serve', {
				ball = LevelMaker.createBall(), 
				bricks = LevelMaker.createMap(1), 
				paddle = self.paddle,
				lives = 3,
				score = 0,
				level = 1
			})
	end

	if love.keyboard.wasPressed('escape') then
		love.event.quit()
	end
end

function PaddleState:render() 
	
	love.graphics.setFont(gFonts['medium'])
	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.printf("Select your paddle:", 0, VIRTUAL_HEIGHT /4, VIRTUAL_WIDTH, 'center')

	self.paddle:render()
	

	love.graphics.setFont(gFonts['small'])
	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.printf("Press 'enter' to confirm the paddle", 0, VIRTUAL_HEIGHT - 40 , VIRTUAL_WIDTH, 'center')
end 

function PaddleState:exit() end 