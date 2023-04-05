DialogueState = Class{__includes=BaseState}

function DialogueState:init(text, callback)
	self.text = text
	self.callback = callback or function() end
end

function DialogueState:update()
	if love.keyboard.keypressed['enter'] or love.keyboard.keypressed['return'] then
		gStateStack:pop()
		self.callback()
	end
end

function DialogueState:render()
	love.graphics.setColor(0, 0, 0.8, 0.8)
	love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, 30)
	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.rectangle('line', 1, 1, VIRTUAL_WIDTH - 2, 28)

	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.setFont(gFonts['medium'])
	love.graphics.printf(self.text, 0, 7, VIRTUAL_WIDTH, 'center')
end