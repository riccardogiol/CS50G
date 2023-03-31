AlienLauncher = Class{}

function AlienLauncher:init(world)
	self.world = world
	self.baseX = 90
    self.baseY = VIRTUAL_HEIGHT - 100
	self.alien = Alien(self.world, 'round', self.baseX, self.baseY, 'static')

	self.shiftingX = 0
	self.shiftingY = 0


	self.aiming = false
	self.launched = false
end

function AlienLauncher:update(dt)
	if not self.launched then
		local currentX, currentY = push:toGame(love.mouse.getPosition())
		if love.mouse.keypressed[1] and self.alien.fixture:testPoint(currentX, currentY) then
			self.aiming = true
		end

		if self.aiming then
			self.shiftingX = math.min(math.max(currentX - self.baseX, -30), 30)
			self.shiftingY = math.min(math.max(currentY - self.baseY, -30), 30)
		end
		if love.mouse.keyreleased[1] and self.aiming then
			self.aiming = false
			self.launched = true
			self.alien.body:destroy()
			self.alien = Alien(self.world, 'round', self.baseX, self.baseY)
			self.alien.body:setLinearVelocity(- self.shiftingX * 10, - self.shiftingY * 10)
			self.alien.body:setAngularDamping(4)
			self.alien.fixture:setRestitution(0.5)
		end
	end

end

function AlienLauncher:render()
	self.alien:render()
	if self.aiming then
		local xTrajPoint, yTrajPoint = self.baseX + self.shiftingX, self.baseY + self.shiftingY, 4
		love.graphics.circle('line', xTrajPoint, yTrajPoint, 4)
		for i=1, 10 do
			xTrajPoint = xTrajPoint - self.shiftingX
			yTrajPoint =  yTrajPoint - self.shiftingY + 0.3 * i * i
			love.graphics.setColor(0.5, 0.5, 0, (10-i)/10)
			love.graphics.circle('line', xTrajPoint, yTrajPoint, 4)
		end
	end
	love.graphics.setColor(1, 1, 1, 1)
end