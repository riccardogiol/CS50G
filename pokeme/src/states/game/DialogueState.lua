DialogueState = Class{__includes=BaseState}

function DialogueState:init(text, callback)
	self.callback = callback or function() end
	self.panel = Panel(0, 0, VIRTUAL_WIDTH, 40)
	self.textbox = Textbox(5, 5, VIRTUAL_WIDTH - 10, 30, text, gFonts['small'])
end

function DialogueState:update()
	if love.keyboard.keypressed['enter'] or love.keyboard.keypressed['return'] then
		local anotherPage = self.textbox:nextPage()
		if not anotherPage then
			gStateStack:pop()
			self.callback()
		end
	end
end

function DialogueState:render()
	self.panel:render()
	self.textbox:render()
end