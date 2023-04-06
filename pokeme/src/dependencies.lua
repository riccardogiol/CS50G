push = require 'lib/push'
Class = require 'lib/class'
Timer = require 'lib/knife/timer'

require 'src/constants'
require 'src/utils'
require 'src/StateStack'
require 'src/StateMachine'
require 'src/Animation'

require 'src/world/Level'
require 'src/world/TileMap'
require 'src/world/Tile'
require 'src/world/tile_ids'

require 'src/entity/Entity'

require 'src/states/BaseState'
require 'src/states/game/StartState'
require 'src/states/game/PlayState'
require 'src/states/game/DialogueState'
require 'src/states/game/FadeState'
require 'src/states/entity/PlayerIdleState'


love.graphics.setDefaultFilter('nearest', 'nearest')

gFonts = {
	['small'] = love.graphics.setNewFont('media/fonts/font.ttf', 8),
	['medium'] = love.graphics.setNewFont('media/fonts/font.ttf', 16),
	['large'] = love.graphics.setNewFont('media/fonts/font.ttf', 32)
}

gTextures = {
    ['tiles'] = love.graphics.newImage('media/images/sheet.png'),
    ['entities'] = love.graphics.newImage('media/images/entities.png'),
    ['cursor'] = love.graphics.newImage('media/images/cursor.png'),

    ['aardart-back'] = love.graphics.newImage('media/images/pokemon/aardart-back.png'),
    ['aardart-front'] = love.graphics.newImage('media/images/pokemon/aardart-front.png'),
    ['agnite-back'] = love.graphics.newImage('media/images/pokemon/agnite-back.png'),
    ['agnite-front'] = love.graphics.newImage('media/images/pokemon/agnite-front.png'),
    ['anoleaf-back'] = love.graphics.newImage('media/images/pokemon/anoleaf-back.png'),
    ['anoleaf-front'] = love.graphics.newImage('media/images/pokemon/anoleaf-front.png'),
    ['bamboon-back'] = love.graphics.newImage('media/images/pokemon/bamboon-back.png'),
    ['bamboon-front'] = love.graphics.newImage('media/images/pokemon/bamboon-front.png'),
    ['cardiwing-back'] = love.graphics.newImage('media/images/pokemon/cardiwing-back.png'),
    ['cardiwing-front'] = love.graphics.newImage('media/images/pokemon/cardiwing-front.png'),
}

gFrames = {
    ['tiles'] = GenerateQuads(gTextures['tiles'], 16, 16),
    ['entities'] = GenerateQuads(gTextures['entities'], 16, 16)
}