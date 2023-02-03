ScoreState = Class{__includes = BaseState}

function ScoreState:update(dt)
	if (love.keyboard.wasPressed('return') or love.keyboard.wasPressed('enter')) then
		gStateMachine:change('play')
	end
end

function ScoreState:render()
	gBackground:render()
	gForeground:render()
	gBird:render()
	for k, pipes_pair in pairs(gPipes_pairs) do
		pipes_pair:render()
	end
	love.graphics.setFont(bigFont)
	love.graphics.printf('GAME OVER', 0, virtual_height/2 - 16, virtual_width, 'center')
	love.graphics.setFont(smallFont)
	love.graphics.printf("Press 'enter' to play again", 0, virtual_height/2 + 20, virtual_width, 'center')
end
