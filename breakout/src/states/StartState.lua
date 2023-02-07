StartState = Class{__includes = BaseState}

function StartState:init() 
end 
function StartState:update() end 
function StartState:render() 
	love.graphics.setFont(gFonts['large'])
	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.printf('Breakout!', 0, VIRTUAL_HEIGHT /2 - 20, VIRTUAL_WIDTH, 'center')
end 