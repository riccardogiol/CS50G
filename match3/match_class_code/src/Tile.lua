--[[
    GD50
    Match-3 Remake

    -- Tile Class --

    Author: Colton Ogden
    cogden@cs50.harvard.edu

    The individual tiles that make up our game board. Each Tile can have a
    color and a variety, with the varietes adding extra points to the matches.
]]

Tile = Class{}

function Tile:init(x, y, color, variety)
    
    -- board positions
    self.gridX = x
    self.gridY = y

    -- coordinate positions
    self.x = (self.gridX - 1) * 32
    self.y = (self.gridY - 1) * 32

    -- tile appearance/points
    self.color = color
    self.variety = variety

    self.shiny = false
    self.shineCircle = 1
end

function Tile:makeItShine()
    self.shiny = true
    Timer.every(0.5, function()
        self.shineCircle = (self.shineCircle%4) + 1
    end)
end


function Tile:render(x, y)
    
    -- draw shadow
    love.graphics.setColor(34/255, 32/255, 52/255, 255/255)
    love.graphics.draw(gTextures['main'], gFrames['tiles'][self.color][self.variety],
        self.x + x + 2, self.y + y + 2)

    -- draw tile itself
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(gTextures['main'], gFrames['tiles'][self.color][self.variety],
        self.x + x, self.y + y)

    if self.shiny then
        if self.shineCircle == 4 then
            love.graphics.setColor(1, 1, 1, 1)
        else
            love.graphics.setColor(1, 1, 1, 0.4)
        end
        love.graphics.rectangle('line', self.x + x + 2, self.y + y + 2, TILE_SIZE - 4, TILE_SIZE - 4, 2)
        if self.shineCircle == 3 then
            love.graphics.setColor(1, 1, 1, 1)
        else
            love.graphics.setColor(1, 1, 1, 0.4)
        end
        love.graphics.rectangle('line', self.x + x + 4, self.y + y + 4, TILE_SIZE - 8, TILE_SIZE - 8, 2)
        if self.shineCircle == 2 then
            love.graphics.setColor(1, 1, 1, 1)
        else
            love.graphics.setColor(1, 1, 1, 0.4)
        end
        love.graphics.rectangle('line', self.x + x + 6, self.y + y + 6, TILE_SIZE - 12, TILE_SIZE - 12, 2)
        love.graphics.setColor(1, 1, 1, 1)
    end
end