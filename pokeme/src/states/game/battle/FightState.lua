FightState = Class{__includes=BaseState}

function FightState:init(battleState)
	self.battleState = battleState
	self.playerFirst = self.battleState.playedPokemon.speed > self.battleState.opponentPokemon.speed
	self.fightStarted = false
end

function FightState:update(dt)
	if not self.fightStarted then
		self.fightStarted = true
		self:startFight()
	end
end

function FightState:startFight()
	if self.playerFirst then
		self:playerAttack(function()
			self:opponentAttack(function()
				self:endFight()
			end)
		end)
	else
		self:opponentAttack(function()
			self:playerAttack(function()
				self:endFight()
			end)
		end)
	end
end

function FightState:playerAttack(onCallback)
	gStateStack:push(BattleDialogueState(
		"Your " .. self.battleState.playedPokemon.name .. " attacks!",
		function() self:playerDamageOpponent(onCallback) end))
end

function FightState:opponentAttack(onCallback)
	gStateStack:push(BattleDialogueState(
		"The opponent " .. self.battleState.opponentPokemon.name .. " attacks!",
		function() self:opponentDamagePlayer(onCallback) end))
end

function FightState:playerDamageOpponent(onCallback)
	local dmg = self:evaluateDamage(self.battleState.playedPokemon, self.battleState.opponentPokemon)
	local finalHP = math.max(self.battleState.opponentPokemon.currentHP - dmg, 0)

	Timer.tween(0.3, {
		 [self.battleState.opponentPokemon] = {currentHP = finalHP}
	}):finish(function()
		if self.battleState.opponentPokemon.currentHP == 0 then
			self:endBattle('player')
		else
			onCallback()
		end
	end)
end

function FightState:opponentDamagePlayer(onCallback)
	local dmg = self:evaluateDamage(self.battleState.opponentPokemon, self.battleState.playedPokemon)
	local finalHP = math.max(self.battleState.playedPokemon.currentHP - dmg, 0)

	Timer.tween(0.3, {
		 [self.battleState.playedPokemon] = {currentHP = finalHP}
	}):finish(function()
		if self.battleState.playedPokemon.currentHP == 0 then
			self:endBattle('opponent')
		else
			onCallback()
		end
	end)
end

function FightState:evaluateDamage(attacker, defender)
	return math.max(attacker.attack - defender.defense, 1)
end

function FightState:endFight()
	gStateStack:pop()
	gStateStack:push(BattleMenuState(self.battleState))
end

function FightState:endBattle(winner)
	if winner == 'player' then
		gStateStack:push(BattleDialogueState(
			"Congratulations! Your pokemon wins!\n" ..
			self.battleState.playedPokemon.name .. " take " .. self.battleState.opponentPokemon.level .. " experience!",
			function()
				local newExperience = self.battleState.playedPokemon.currentExp + self.battleState.opponentPokemon.level
				local levelUps = newExperience >= self.battleState.playedPokemon.expToLevel
				if levelUps then
					newExperience = newExperience % self.battleState.playedPokemon.expToLevel
					Timer.tween(1.5, {
						 [self.battleState.playedPokemon] = {currentExp = self.battleState.playedPokemon.expToLevel}
					}):finish(function()
						self.battleState.playedPokemon:levelUp()
						gStateStack:push(BattleDialogueState(
							"Congratulations! Your pokemon leveled up!\n",
							function()
								Timer.tween(1.5, {
									 [self.battleState.playedPokemon] = {currentExp = newExperience}
								}):finish(function()
									gStateStack:push(FadeState(
										{ r = 1, g = 1, b = 1, a = 0},
										{ r = 1, g = 1, b = 1, a = 1},
										0.5, 
										function()
											gStateStack:pop()
											gStateStack:pop()
											gStateStack:push(FadeState(
												{ r = 1, g = 1, b = 1, a = 1},
												{ r = 1, g = 1, b = 1, a = 0},
												0.5, 
												function() end))
										end))
								end)
							end))
					end)
				else
					Timer.tween(1.5, {
						 [self.battleState.playedPokemon] = {currentExp = newExperience}
					}):finish(function()
						gStateStack:push(FadeState(
							{ r = 1, g = 1, b = 1, a = 0},
							{ r = 1, g = 1, b = 1, a = 1},
							0.5, 
							function()
								gStateStack:pop()
								gStateStack:pop()
								gStateStack:push(FadeState(
									{ r = 1, g = 1, b = 1, a = 1},
									{ r = 1, g = 1, b = 1, a = 0},
									0.5, 
									function() end))
							end))
					end)
				end
			end))
	else
		gStateStack:push(BattleDialogueState(
			"Oh no! Your pokemon faint!\n" ..
			"The opponent " .. self.battleState.playedPokemon.name .. " run away...",
			function() 
				gStateStack:push(FadeState(
					{ r = 1, g = 1, b = 1, a = 0},
					{ r = 1, g = 1, b = 1, a = 1},
					0.5, 
					function()
						gStateStack:pop()
						gStateStack:pop()
						self.battleState.playedPokemon.currentHP = self.battleState.playedPokemon.HP
						gStateStack:push(DialogueState(
							"Your pokemon is recovered!",
							function() end))
						gStateStack:push(FadeState(
							{ r = 1, g = 1, b = 1, a = 1},
							{ r = 1, g = 1, b = 1, a = 0},
							0.5, 
							function() end))
					end))
			end))

	end
end

function FightState:printName()
	print('FightState')
end
