PlacedImage = Class{}

function PlacedImage:init(image, x, y, width, height)
	self.image = image
	self.imageWidth = self.image:getWidth()
	self.imageHeigth = self.image:getHeight()
	self.x = x 
	self.y = y
	self.width = width 
	self.height = height
end

function PlacedImage:render()
	love.graphics.draw(self.image, self.x, self.y, 0, self.width/(self.imageWidth - 1), self.height/(self.imageHeigth-1))
end