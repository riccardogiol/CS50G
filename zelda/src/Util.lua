function GenerateQuads(atlas, tilewidth, tileheight)
    local sheetWidth = atlas:getWidth() / tilewidth
    local sheetHeight = atlas:getHeight() / tileheight
    local quadCounter = 1
    local quads = {}

    for y = 0, sheetHeight - 1 do
        for x = 0, sheetWidth - 1 do
            quads[quadCounter] = love.graphics.newQuad(x * tilewidth, y * tileheight, tilewidth, tileheight, atlas:getDimensions())
            quadCounter = quadCounter + 1
        end
    end

    return quads
end

function ParseAnimations(animationsDefs)
    animations = {}
    for name, animDef in pairs(animationsDefs) do
        animations[name] = Animation(animDef)
    end
    return animations
end