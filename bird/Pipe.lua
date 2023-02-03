Pipe = Class{}

function Pipe:init(image, x, y, speed, flipped)
	self.image = image
	self.x = x 
	self.y = y 
	self.speed = speed
	self.flipped = flipped
end

function Pipe:updatePosition(dt)
	self.x = self.x - self.speed*dt
end

function Pipe:isOutL()
	if (self.x + self.image:getWidth()) < 0 then
		return true
	end
	return false
end

function Pipe:render()
	if self.flipped then
		love.graphics.draw(self.image, self.x, self.y + self.image:getHeight(), 0, 1, -1)
	else
		love.graphics.draw(self.image, self.x, self.y)
	end
end


PipesPair = Class{}

function PipesPair:init(image, x_gap_top, y_gap_top, speed)
	gap_height = 120
	self.pipe_bottom = Pipe(image, x_gap_top, y_gap_top + gap_height, speed, false)
	self.pipe_top = Pipe(image, x_gap_top, y_gap_top - image:getHeight(), speed, true)
end

function PipesPair:updatePosition(dt)
	self.pipe_bottom:updatePosition(dt)
	self.pipe_top:updatePosition(dt)
end

function PipesPair:isOutL()
	return self.pipe_bottom:isOutL()
end

function PipesPair:render()
	self.pipe_bottom:render()
	self.pipe_top:render()
end