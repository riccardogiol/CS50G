BattleState = Class{__includes=BaseState}

function BattleState:init()
	self.playerPV = ProgressBar({
		x = 50,
		y = 50, 
		width = 60, 
		height = 3, 
		maxValue = 100, 
		currentValue = 100, 
		color = {1, 0, 0, 1}
	})

	self.battleStarted = false
	self.renderPokeSpecs = false

    self.playerCircleX = -68
    self.opponentCircleX = VIRTUAL_WIDTH + 32
    self.bottomPanel = Panel(0, VIRTUAL_HEIGHT - 64, VIRTUAL_WIDTH, 64, {0.5, 0.5, 0.5, 1})

end

function BattleState:update(dt)
	if not self.battleStarted then
		self:startBattle()
	end
end

function BattleState:startBattle()
	self.battleStarted = true
	Timer.tween(1, {
		[self] = {playerCircleX = 66, opponentCircleX = VIRTUAL_WIDTH - 70}
	}):finish(function()
		gStateStack:push(DialogueState(
			'Battle is gonna start soon',
			function()
				gStateStack:push(BattleMenuState(self))
			end))
		self.renderPokeSpecs = true
	end)
end

function BattleState:render()
    love.graphics.clear(214/255, 214/255, 214/255, 1)

    love.graphics.setColor(45/255, 184/255, 45/255, 124/255)
    love.graphics.ellipse('fill', self.opponentCircleX, 60, 72, 24)
    love.graphics.ellipse('fill', self.playerCircleX, VIRTUAL_HEIGHT - 64, 72, 24)
    if self.renderPokeSpecs then
		self.playerPV:render()
	end
	self.bottomPanel:render()
end