TitleState = Class{__includes = BaseState}

function TitleState:update(dt)
	--update images position 
	gBackground:updatePosition(dt)
	gForeground:updatePosition(dt)

	if (love.keyboard.wasPressed('return') or love.keyboard.wasPressed('enter')) then
		gStateMachine:change('countdown')
	end
end

function TitleState:render()
	gBackground:render()
	gForeground:render()
	love.graphics.setFont(bigFont)
	love.graphics.printf('Plappy Bird!', 0, virtual_height/2 - 22, virtual_width, 'center')
	love.graphics.setFont(smallFont)
	love.graphics.printf("Press 'enter' to play again", 0, virtual_height/2 + 12, virtual_width, 'center')
end
