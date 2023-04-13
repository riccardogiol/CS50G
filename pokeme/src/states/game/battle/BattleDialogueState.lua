BattleDialogueState = Class{__includes=BaseState}

function BattleDialogueState:init(text, callback)
	self.callback = callback or function() end
	self.panel = Panel(0, VIRTUAL_HEIGHT - 64, VIRTUAL_WIDTH, 64, {0, 0, 0.8, 1})
	self.textbox = Textbox(5, VIRTUAL_HEIGHT - 59, VIRTUAL_WIDTH - 10, 54, text, gFonts['small'])
end

function BattleDialogueState:update()
	if love.keyboard.keypressed['enter'] or love.keyboard.keypressed['return'] then
		local anotherPage = self.textbox:nextPage()
		if not anotherPage then
			gStateStack:pop()
			self.callback()
		end
	end
end

function BattleDialogueState:render()
	self.panel:render()
	self.textbox:render()
end

function BattleDialogueState:printName()
	print('BattleDialogueState')
end