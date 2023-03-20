Doorway = Class{}

function Doorway:init(def)
	self.open = def.open
	self.direction = def.direction

	self.x = def.x
	self.y = def.y

	if self.direction == 'left' or direction == 'right' then
		self.width = 16
		self.height = 32
	else
		self.width = 32
		self.height = 16
	end
end

function Doorway:render()
    local texture = gTextures['tiles']
    local quads = gFrames['tiles']

	if self.direction == 'left' then
        if self.open then
            love.graphics.draw(texture, quads[181], self.x - TILE_SIZE, self.y)
            love.graphics.draw(texture, quads[182], self.x, self.y)
            love.graphics.draw(texture, quads[200], self.x - TILE_SIZE, self.y + TILE_SIZE)
            love.graphics.draw(texture, quads[201], self.x, self.y + TILE_SIZE)
        else
            love.graphics.draw(texture, quads[219], self.x - TILE_SIZE, self.y)
            love.graphics.draw(texture, quads[220], self.x, self.y)
            love.graphics.draw(texture, quads[238], self.x - TILE_SIZE, self.y + TILE_SIZE)
            love.graphics.draw(texture, quads[239], self.x, self.y + TILE_SIZE)
        end
    elseif self.direction == 'right' then
        if self.open then
            love.graphics.draw(texture, quads[172], self.x, self.y)
            love.graphics.draw(texture, quads[173], self.x + TILE_SIZE, self.y)
            love.graphics.draw(texture, quads[191], self.x, self.y + TILE_SIZE)
            love.graphics.draw(texture, quads[192], self.x + TILE_SIZE, self.y + TILE_SIZE)
        else
            love.graphics.draw(texture, quads[174], self.x, self.y)
            love.graphics.draw(texture, quads[175], self.x + TILE_SIZE, self.y)
            love.graphics.draw(texture, quads[193], self.x, self.y + TILE_SIZE)
            love.graphics.draw(texture, quads[194], self.x + TILE_SIZE, self.y + TILE_SIZE)
        end
    elseif self.direction == 'up' then
        if self.open then
            love.graphics.draw(texture, quads[98], self.x, self.y - TILE_SIZE)
            love.graphics.draw(texture, quads[99], self.x + TILE_SIZE, self.y - TILE_SIZE)
            love.graphics.draw(texture, quads[117], self.x, self.y)
            love.graphics.draw(texture, quads[118], self.x + TILE_SIZE, self.y)
        else
            love.graphics.draw(texture, quads[134], self.x, self.y - TILE_SIZE)
            love.graphics.draw(texture, quads[135], self.x + TILE_SIZE, self.y - TILE_SIZE)
            love.graphics.draw(texture, quads[153], self.x, self.y)
            love.graphics.draw(texture, quads[154], self.x + TILE_SIZE, self.y)
        end
    else
        if self.open then
            love.graphics.draw(texture, quads[141], self.x, self.y)
            love.graphics.draw(texture, quads[142], self.x + TILE_SIZE, self.y)
            love.graphics.draw(texture, quads[160], self.x, self.y + TILE_SIZE)
            love.graphics.draw(texture, quads[161], self.x + TILE_SIZE, self.y + TILE_SIZE)
        else
            love.graphics.draw(texture, quads[216], self.x, self.y)
            love.graphics.draw(texture, quads[217], self.x + TILE_SIZE, self.y)
            love.graphics.draw(texture, quads[235], self.x, self.y + TILE_SIZE)
            love.graphics.draw(texture, quads[236], self.x + TILE_SIZE, self.y + TILE_SIZE)
        end
    end
end

