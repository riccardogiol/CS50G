push = require 'lib/push'
Class = require 'lib/class'
Timer = require 'lib/Knife.timer'

require 'src/utils'
require 'src/constants'

require 'src/Alien'
require 'src/Background'
require 'src/Level'

require 'src/StateMachine'
require 'src/states/BaseState'
require 'src/states/game/StartState'
require 'src/states/game/PlayState'

love.graphics.setDefaultFilter('nearest', 'nearest')
gTextures = {
    ['aliens'] = love.graphics.newImage('media/images/aliens.png'),
    ['tiles'] = love.graphics.newImage('media/images/tiles.png'),
    ['colored-desert'] = love.graphics.newImage('media/images/colored_desert.png')
}


gFrames = {
    ['aliens'] = GenerateQuads(gTextures['aliens'], 35, 35),
    ['tiles'] = GenerateQuads(gTextures['tiles'], 35, 35)
}

gFonts = {
    ['small'] = love.graphics.newFont('media/fonts/font.ttf', 8),
    ['medium'] = love.graphics.newFont('media/fonts/font.ttf', 16),
    ['large'] = love.graphics.newFont('media/fonts/font.ttf', 32),
    ['huge'] = love.graphics.newFont('media/fonts/font.ttf', 64)
}