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
	if self.playerFirst or true then
		self:playerAttack(function()
			self:opponentAttack(function()
				self:endFight()
			end)
		end)
	end
end

function FightState:playerAttack(onCallback)
	gStateStack:push(BattleDialogueState(
		self.battleState.playedPokemon.name .. " attacks!",
		function() self:playerDamageOpponent(onCallback) end))
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

function FightState:evaluateDamage(attacker, defender)
	return math.max(attacker.attack - defender.defense, 1)
end

function FightState:opponentAttack(onCallback)
	print('opponent attack')
	onCallback()
end

function FightState:endFight()
	gStateStack:pop()
end

function FightState:endBattle(winner)
	if winner == 'player' then
		gStateStack:push(BattleDialogueState(
			"Congratulations! Your pokemon wins!\n" ..
			self.battleState.playedPokemon.name .. " take XXX experience!",
			function() 
				gStateStack:push(FadeState(
					{ r = 1, g = 1, b = 1, a = 0},
					{ r = 1, g = 1, b = 1, a = 1},
					0.5, 
					function()
						gStateStack:pop()
						gStateStack:pop()
						gStateStack:pop()
						gStateStack:push(FadeState(
							{ r = 1, g = 1, b = 1, a = 1},
							{ r = 1, g = 1, b = 1, a = 0},
							0.5, 
							function() end))
					end))
			end))
	else

	end
end

function FightState:printName()
	print('FightState')
end
