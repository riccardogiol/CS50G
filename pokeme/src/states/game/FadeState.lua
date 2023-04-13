FadeState = Class{__includes = BaseState}

function FadeState:init(startColor, endColor, duration, onFadeComplete)
	self.color = startColor
	self.duration = duration
	self.endColor = endColor
	self.onFadeComplete = onFadeComplete
	Timer.tween(self.duration, {
		[self.color] = {
			r = self.endColor.r,
			g = self.endColor.g,
			b = self.endColor.b,
			a = self.endColor.a
		}
	})
	:finish(function()
		gStateStack:pop()
		onFadeComplete()
	end)
end

function FadeState:render()
	love.graphics.setColor(self.color.r, self.color.g, self.color.b, self.color.a)
	love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
	love.graphics.setColor(1, 1, 1, 1)
end

function FadeState:printName()
	print('FadeState')
end