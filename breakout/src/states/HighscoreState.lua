HighscoreState = Class{}

function HighscoreState:init()
	self.scores = loadHighScore()
end 

function HighscoreState:update(dt)	
	if love.keyboard.wasPressed('escape') then
		gStateMachine:change('start')
	end
end 

function HighscoreState:render()
	love.graphics.setFont(gFonts['large'])
	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.printf("High Scores", 0, 30, VIRTUAL_WIDTH, 'center')
	local counter = 0
	for k, score in pairs(self.scores) do
		love.graphics.setFont(gFonts['score'])
		love.graphics.setColor(1, 1, 1, 1)
		love.graphics.printf(tostring(k) .. "." , VIRTUAL_WIDTH/3, VIRTUAL_HEIGHT/3 + k*12, VIRTUAL_WIDTH/3, 'left')
		love.graphics.printf(score.name, VIRTUAL_WIDTH/3, VIRTUAL_HEIGHT/3 + k*12, VIRTUAL_WIDTH/3, 'center')
		love.graphics.printf(tostring(score.score), VIRTUAL_WIDTH/3, VIRTUAL_HEIGHT/3 + k*12, VIRTUAL_WIDTH/3, 'right')
	end
end 