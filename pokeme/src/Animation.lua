Animation = Class{}

function Animation:init(def)
	self.texture = def.texture
	self.frames = def.frames
	self.interval = def.interval
	self.loop = def.loop

	self.currentFrame = 1
	self.timer = 0
	self.looped = false
end

function Animation:refreshed()
	self.timer = 0
	self.currentFrame = 1
	self.looped = false
end

function Animation:update(dt)
	if #self.frames == 1 or (not self.loop and self.looped) then
		return
	end

	self.timer = self.timer + dt
	if self.timer > self.interval then
		self.timer = self.timer % self.interval
		local lastFrame = self.currentFrame
		self.currentFrame = (self.currentFrame % #self.frames) + 1
		if not self.loop then
			if lastFrame > self.currentFrame then
				self.looped = true
				self.currentFrame = lastFrame
			end
		end
	end
end

function Animation:getCurrentFrame()
	return self.frames[self.currentFrame]
end