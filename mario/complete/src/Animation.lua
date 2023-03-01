Animation = Class{}

function Animation:init(def)
	self.frames = def.frames
	self.interval = def.interval
	self.timer = 0
	self.currentFrame = 0
end

function Animation:update(dt)
	if #self.frames > 1 then
		self.timer = self.timer + dt
		if self.timer > self.interval then
			self.timer = self.timer % self.interval
			self.currentFrame = (self.currentFrame + 1) % #self.frames
		end
	end
end

function Animation:getCurrentFrame()
	return self.frames[self.currentFrame + 1]
end
