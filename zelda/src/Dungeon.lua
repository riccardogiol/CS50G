Dungeon = Class{}

function Dungeon:init(player)
	self.currentRoom = Room()
	self.player = player
end

function Dungeon:update(dt)
	self.player:update(dt)
end

function Dungeon:render()
	self.currentRoom:render()
	self.player:render()
end