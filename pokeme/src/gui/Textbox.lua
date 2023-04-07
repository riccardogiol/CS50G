Textbox = Class{}

function Textbox:init(x, y, width, height, text, font)
	self.x = x
	self.y = y
	self.width = width
	self.height = height
	self.text = text
	self.font = font or gFonts['small']

	_, self.textChunks = self.font:getWrap(self.text, self.width)
	self.lineHeight = self.font:getHeight() + 2
	self.linesPerPanel = math.floor(self.height / self.lineHeight)

	self.chunksToDisplay = {}
	self.chunksCounter = 1
	self.finish = false

	self:loadNextChunks()
end

function Textbox:nextPage()
	if self.finish then
		return false
	else
		self:loadNextChunks()
		return true
	end
end

function Textbox:loadNextChunks()
	self.chunksToDisplay = {}
	for i=1, self.linesPerPanel do
		self.chunksToDisplay[i] = self.textChunks[self.chunksCounter]
		if self.chunksCounter == #self.textChunks then
			self.finish = true
			return
		end
		self.chunksCounter = self.chunksCounter + 1
	end
end

function Textbox:render()
	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.setFont(self.font)
	for i, line in pairs(self.chunksToDisplay) do
		love.graphics.print(line, self.x, self.y + (i - 1) * self.lineHeight)
	end
end
