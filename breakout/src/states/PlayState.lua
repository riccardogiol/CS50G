PlayState = Class{}

function PlayState:init()
	local paddle_quads = GeneratePaddleQuads(gTextures['main'])
	color = math.random(0, 4)
	difficulty = 1
	w, h = paddle_quads[color][difficulty]:getQuadDimensions()
	self.paddle = Paddle(paddle_quads[color][difficulty].quad, w, h, (VIRTUAL_WIDTH - w)/2, VIRTUAL_HEIGHT - 32, 250)
end 

function PlayState:enter() end 

function PlayState:update(dt)
	if love.keyboard.isDown('left') then
		self.paddle:updatePosition(dt, 'left')
	elseif love.keyboard.isDown('right') then
		self.paddle:updatePosition(dt, 'right')
	end

	if love.keyboard.wasPressed('escape') then
		love.event.quit()
	end

end 
function PlayState:render() 
	self.paddle:render()
end 
function PlayState:exit() end 