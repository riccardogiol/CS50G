Animation = Class{}

function Animation:init(def)
	self.frames = def.frames
	self.texture = def.texture
	self.interval = def.interval
	self.looping = def.looping
	self.loopExecuted = false

	self.currentFrame = 1
	self.timer = 0
end

function Animation:update(dt)
	if self.loopExecuted then
		return
	end

	local oldFrame = self.currentFrame
	self.timer = self.timer + dt
	if self.timer > self.interval then
		self.timer = self.timer % self.interval
		self.currentFrame = (self.currentFrame % #self.frames) + 1
	end

	if not self.looping and oldFrame > self.currentFrame then
		self.currentFrame = #self.frames
		self.loopExecuted = true
		return
	end
end

function Animation:refresh()
	self.currentFrame = 1
	self.loopExecuted = false
	self.timer = 0
end

function Animation:getCurrentFrame()
	return self.frames[self.currentFrame]
end