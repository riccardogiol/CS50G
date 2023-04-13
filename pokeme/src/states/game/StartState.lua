StartState = Class{__includes = BaseState}

function StartState:init()
	self.sprite = BattleSprite(POKEMON_DEFS[POKEMON_IDS[math.random(#POKEMON_IDS)]].battleSpriteFront,
		VIRTUAL_WIDTH / 2 - 32,
		VIRTUAL_HEIGHT / 2 - 16)

    self.tween = Timer.every(3, function()
        Timer.tween(0.2, {
            [self.sprite] = {x = -64}
        })
        :finish(function()
            self.sprite = BattleSprite(POKEMON_DEFS[POKEMON_IDS[math.random(#POKEMON_IDS)]].battleSpriteFront, 
            	VIRTUAL_WIDTH,
            	VIRTUAL_HEIGHT / 2 - 16)

            Timer.tween(0.2, {
                [self.sprite] = {x = VIRTUAL_WIDTH / 2 - 32}
            })
        end)
    end)
end

function StartState:update(dt)
	if love.keyboard.keypressed['enter'] or love.keyboard.keypressed['return'] then
		gStateStack:push(FadeState(
			{ r = 1, g = 1, b = 1, a = 0},
			{ r = 1, g = 1, b = 1, a = 1},
			1, 
			function()
				gStateStack:pop()
				gStateStack:push(PlayState())
				gStateStack:push(DialogueState('We are nthe play state!We are now in the play state!We are now in the play state!We are now in the play state!We are now in the play state!We are now in the play state! We are now in the play state!We are now in the play state!We are now in the play state!We are now in the play state!We are now in the play state!We are now in the play state!We are now in the play state!We are now in the play state!We are now in the play state!We are now in the play state!We are now in the play state!We are now in the play state!We are now in the play state!'))
				gStateStack:push(FadeState(
					{ r = 1, g = 1, b = 1, a = 1},
					{ r = 1, g = 1, b = 1, a = 0},
					1, 
					function() end))
			end))
	end
end

function StartState:render()
	love.graphics.clear(188/255, 188/255, 188/255, 1)

    love.graphics.setColor(24/255, 24/255, 24/255, 1)
    love.graphics.setFont(gFonts['large'])
    love.graphics.printf('Pokeme!', 0, VIRTUAL_HEIGHT / 2 - 72, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(gFonts['medium'])
    love.graphics.printf('Press Enter', 0, VIRTUAL_HEIGHT / 2 + 68, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(gFonts['small'])

    love.graphics.setColor(45/255, 184/255, 45/255, 124/255)
    love.graphics.ellipse('fill', VIRTUAL_WIDTH / 2, VIRTUAL_HEIGHT / 2 + 32, 72, 24)

    self.sprite:render()
end

function StartState:printName()
	print('StartState')
end
