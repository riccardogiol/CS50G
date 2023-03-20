Animation = Class{}

function Animation:init(def)
	self.frames = def.frames
	self.texture = def.texture
	self.interval = def.interval
	self.looping = def.looping or true

	self.currentFrame = 1
	self.timer = 0
end

function Animation:update(dt)
	self.timer = self.timer + dt
	if self.timer > self.interval then
		if not self.looping then
			return
		end
		self.timer = self.timer % self.interval
		self.currentFrame = (self.currentFrame % #self.frames) + 1
	end
end

function Animation:getCurrentFrame()
	return self.frames[self.currentFrame]
end