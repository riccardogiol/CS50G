--[[
    GD50
    Super Mario Bros. Remake

    -- GameLevel Class --

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

GameLevel = Class{}

function GameLevel:init(entities, objects, tilemap)
    self.entities = entities
    self.objects = objects
    self.tileMap = tilemap
end

--[[
    Remove all nil references from tables in case they've set themselves to nil.
]]
function GameLevel:clear()
    for i = #self.objects, 1, -1 do
        if not self.objects[i] then
            table.remove(self.objects, i)
        end
    end

    for i = #self.entities, 1, -1 do
        if not self.objects[i] then
            table.remove(self.objects, i)
        end
    end
end

function GameLevel:checkIfObjectInColumn(column)
    for i, obj in pairs(self.objects) do
        local objTile = self.tileMap:pointToTile(obj.x + 1, obj.y + 1)
        if objTile.x == column then
            return true
        end
    end
    return false
end

function GameLevel:giveFirstColumnWithSolidGround()
    for x = 1, self.tileMap.width do
        if self.tileMap.tiles[self.tileMap.height][x].id == TILE_ID_GROUND then
            return x
        end
    end
    return nil
end

function GameLevel:addLockAndKey(player)
    local objInColumn = true
    local randomColumn1 = nil
    local randomColumn2 = nil
    while objInColumn do
        randomColumn1 = self.tileMap:randomSolidGroundColumn()
        if randomColumn1 == nil then
            return error("no column find with solid ground")
        end
        objInColumn = self:checkIfObjectInColumn(randomColumn1)
        if objInColumn then
            print("Try to add object in column " .. randomColumn1 .. " where object already present")
        end
    end
    objInColumn = true
    while objInColumn do
        randomColumn2 = self.tileMap:randomSolidGroundColumn()
        if randomColumn2 == nil then
            return error("no column find with solid ground")
        end
        objInColumn = self:checkIfObjectInColumn(randomColumn2)
        objInColumn = objInColumn and (randomColumn2 == randomColumn1)
        if objInColumn then
            print("Try to add object in column " .. randomColumn1 .. " where object already present")
        end
    end
    print(randomColumn1)
    print(randomColumn2)
    local keyColor = math.random(4)
    local lockBlock = GameObject {
        texture = 'keys-locks',
        x = (randomColumn1 - 1) * TILE_SIZE,
        y = 3 * TILE_SIZE,
        width = 16,
        height = 16,
        player = player,

        frame = 4 + keyColor,
        collidable = true,
        hit = false,
        solid = true,
        destroyAfterCollision = true,

        -- collision function takes itself
        onCollide = function(obj)
            if not obj.hit then
                if obj.player.key then
                    gSounds['powerup-reveal']:play()
                    obj.hit = true
                    obj.player.key = nil
                end
            end
            gSounds['empty-block']:play()
        end
    }
    table.insert(self.objects, lockBlock)

    local keyBlock = GameObject {
        texture = 'jump-blocks',
        x = (randomColumn2 - 1) * TILE_SIZE,
        y = 3 * TILE_SIZE,
        width = 16,
        height = 16,

        -- make it a random variant
        frame = math.random(#JUMP_BLOCKS),
        collidable = true,
        hit = false,
        solid = true,

        -- collision function takes itself
        onCollide = function(obj)

            -- spawn a gem if we haven't already hit the block
            if not obj.hit then
                    local key = GameObject {
                        texture = 'keys-locks',
                        x = (randomColumn2 - 1) * TILE_SIZE,
                        y = 3 * TILE_SIZE - 4,
                        width = 16,
                        height = 16,
                        frame = keyColor,
                        collidable = true,
                        consumable = true,
                        solid = false,

                        onConsume = function(player, object)
                            gSounds['pickup']:play()
                            player.key = keyColor
                            print(player.key)
                        end
                    }
                    
                    Timer.tween(0.1, {
                        [key] = {y = 2 * TILE_SIZE}
                    })
                    gSounds['powerup-reveal']:play()

                    table.insert(self.objects, key)

                obj.hit = true
            end

            gSounds['empty-block']:play()
        end
    }
    table.insert(self.objects, keyBlock)

end

function GameLevel:update(dt)
    self.tileMap:update(dt)

    for k, object in pairs(self.objects) do
        object:update(dt)
    end

    for k, entity in pairs(self.entities) do
        entity:update(dt)
    end
end

function GameLevel:render()
    self.tileMap:render()

    for k, object in pairs(self.objects) do
        object:render()
    end

    for k, entity in pairs(self.entities) do
        entity:render()
    end
end