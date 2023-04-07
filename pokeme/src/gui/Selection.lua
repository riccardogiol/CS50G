Selection = Class{}

function Selection:init(def)
	self.items = def.items
	self.x = def.x
	self.y = def.y
	self.font = def.font or gFonts['small']
	self.lineSpacing = def.lineSpacing or 2

	self.currentSelection = 1
end

function Selection:update(dt)
	if love.keyboard.keypressed['down'] then
		self.currentSelection = math.min(self.currentSelection + 1, #self.items)
	elseif love.keyboard.keypressed['up'] then
		self.currentSelection = math.max(self.currentSelection - 1, 1)
	elseif love.keyboard.keypressed['enter'] or love.keyboard.keypressed['return'] then
		self.items[self.currentSelection].callback()
	end
end

function Selection:render()
	love.graphics.setFont(self.font)
	local fontHeight = self.font:getHeight()
	for i, item in pairs(self.items) do
		local itemX = self.x
		local itemY = self.y + (i - 1) * (self.lineSpacing + fontHeight)
		if self.currentSelection == i then
			love.graphics.draw(gTextures['cursor'], itemX - 20, itemY)
		end
		love.graphics.setColor(1, 1, 1, 1)
		love.graphics.print(item.text, itemX, itemY)
	end
end
