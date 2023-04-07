BattleState = Class{__includes=BaseState}

function BattleState:render()
	love.graphics.print('In BattleState', 3, 15)
end