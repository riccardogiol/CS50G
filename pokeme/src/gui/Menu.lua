Menu = Class{}

function Menu:init(def)
	self.panel = Panel(def.x, def.y, def.width, def.height)
	self.selection = Selection({
		x = def.x + 3,
		y = def.y + 3,
		items = def.items})
end

function Menu:update(dt)
	self.selection:update(dt)
end

function Menu:render()
	self.panel:render()
	self.selection:render()
end