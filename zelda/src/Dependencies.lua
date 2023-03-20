Class = require 'lib/class'
Event = require 'lib/knife.event'
push = require 'lib/push'
Timer = require 'lib/knife.timer'

require 'src/constants'
require 'src/entity_defs'
require 'src/StateMachine'
require 'src/Animation'
require 'src/Dungeon'
require 'src/Room'
require 'src/Entity'
require 'src/Player'
require 'src/Util'

require 'src/states/BaseState'
require 'src/states/game/PlayState'
require 'src/states/player/PlayerIdleState'
require 'src/states/player/PlayerMovingState'


love.graphics.setDefaultFilter('nearest', 'nearest')
gTextures = {
    ['tiles'] = love.graphics.newImage('media/images/tilesheet.png'),
    ['background'] = love.graphics.newImage('media/images/background.png'),
    ['character-walk'] = love.graphics.newImage('media/images/character_walk.png')
}
gFrames = {
    ['tiles'] = GenerateQuads(gTextures['tiles'], 16, 16),
    ['character-walk'] = GenerateQuads(gTextures['character-walk'], 16, 32)
}

gFonts = {
    ['small'] = love.graphics.newFont('media/fonts/font.ttf', 8),
    ['medium'] = love.graphics.newFont('media/fonts/font.ttf', 16),
    ['large'] = love.graphics.newFont('media/fonts/font.ttf', 32),
    ['gothic-medium'] = love.graphics.newFont('media/fonts/GothicPixels.ttf', 16),
    ['gothic-large'] = love.graphics.newFont('media/fonts/GothicPixels.ttf', 32),
    ['zelda'] = love.graphics.newFont('media/fonts/zelda.otf', 64),
    ['zelda-small'] = love.graphics.newFont('media/fonts/zelda.otf', 32)
}