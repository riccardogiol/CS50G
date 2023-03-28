StartState = Class{__includes = BaseState}

function StartState:init()
	self.world = love.physics.newWorld(0, 300)
	self.alien = Alien(self.world, 'square', 30, 30)
end

function StartState:enter() end

function StartState:update(dt)
	self.world:update(dt)
    if love.keyboard.keypressed['escape'] then
        love.event.quit()
    end
end

function StartState:render()
	self.alien:render()
end