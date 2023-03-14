Class = require 'lib/class'
Event = require 'lib/knife.event'
push = require 'lib/push'
Timer = require 'lib/knife.timer'

require 'src/constants'
require 'src/StateMachine'
require 'src/Room'
require 'src/Util'

require 'src/states/BaseState'
require 'src/states/game/PlayState'


love.graphics.setDefaultFilter('nearest', 'nearest')
gTextures = {
    ['tiles'] = love.graphics.newImage('media/images/tilesheet.png'),
    ['background'] = love.graphics.newImage('media/images/background.png')
}
gFrames = {
    ['tiles'] = GenerateQuads(gTextures['tiles'], 16, 16)
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