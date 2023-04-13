BattleState = Class{__includes=BaseState}

function BattleState:init(player)
	self.player = player
	self.opponentPokemon = Pokemon(Pokemon.getRandomDef(), 5)
	self.playedPokemon = self.player.party.pokemons[1]

	self.playerSprite = BattleSprite(self.playedPokemon.battleSpriteBack, -64, VIRTUAL_HEIGHT - 128)
    self.opponentSprite = BattleSprite(self.opponentPokemon.battleSpriteFront, VIRTUAL_WIDTH, 8)

	self.playerPV = ProgressBar({
		x = VIRTUAL_WIDTH - 160,
		y = VIRTUAL_HEIGHT - 80, 
		width = 150, 
		height = 4, 
		maxValue = self.playedPokemon.HP, 
		currentValue = self.playedPokemon.currentHP, 
		color = {1, 0, 0, 1}
	})
	self.playerXP = ProgressBar {
        x = VIRTUAL_WIDTH - 160,
        y = VIRTUAL_HEIGHT - 73,
        width = 150,
        height = 4,
        color = {0, 1, 1, 1},
        currentValue = self.playedPokemon.currentExp,
        maxValue = self.playedPokemon.expToLevel
    }

	self.opponentPV = ProgressBar({
		x = 8,
		y = 8, 
		width = 150, 
		height = 4, 
		maxValue = self.opponentPokemon.HP, 
		currentValue = self.opponentPokemon.currentHP, 
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
		[self.playerSprite] = {x = 32},
		[self.opponentSprite] = {x = VIRTUAL_WIDTH - 96},
		[self] = {playerCircleX = 66, opponentCircleX = VIRTUAL_WIDTH - 70}
	}):finish(function()
		gStateStack:push(BattleDialogueState(
			'A wild ' .. self.opponentPokemon.name .. ' appeared!',
			function()
				gStateStack:push(BattleDialogueState(
					'Go ' .. self.playedPokemon.name .. '!',
					function()
						gStateStack:push(BattleMenuState(self))
					end))
			end))
		self.renderPokeSpecs = true
	end)
end

function BattleState:updatePVs()
	self.playerPV.currentValue = self.playedPokemon.currentHP
	self.playerXP.currentValue = self.playedPokemon.currentExp
	self.opponentPV.currentValue = self.opponentPokemon.currentHP
end

function BattleState:render()
    love.graphics.clear(214/255, 214/255, 214/255, 1)

    love.graphics.setColor(45/255, 184/255, 45/255, 124/255)
    love.graphics.ellipse('fill', self.opponentCircleX, 60, 72, 24)
    love.graphics.ellipse('fill', self.playerCircleX, VIRTUAL_HEIGHT - 64, 72, 24)

    self.playerSprite:render()
    self.opponentSprite:render()
    if self.renderPokeSpecs then
    	self:updatePVs()
		self.playerPV:render()
		self.opponentPV:render()
		self.playerXP:render()

		love.graphics.setColor(0, 0, 0, 1)
        love.graphics.setFont(gFonts['small'])
        love.graphics.print('LV ' .. tostring(self.playedPokemon.level),
            self.playerPV.x, self.playerPV.y - 10)
        love.graphics.print('LV ' .. tostring(self.opponentPokemon.level),
            self.opponentPV.x, self.opponentPV.y + 8)
	end
	self.bottomPanel:render()
end

function BattleState:printName()
	print('BattleState')
end