PlayState = Class{__includes = BaseState}

pipe_offset = 120
number_of_pipes = 0
y_max_gaps_difference = 70


function PlayState:init()
	gBird = Bird('images/Bird.png', virtual_width/2, virtual_height/2, 300, 150)
	last_gap_y = virtual_height / 3
	gPipes_pairs = {}
	self.score = 0
end


function PlayState:update(dt)
	--update images position 
	gBackground:updatePosition(dt)
	gForeground:updatePosition(dt)

	--update gBird position
	gBird:updatePosition(dt)
	if gBird:collidesBorder(0 - 4, virtual_height - 16 + 4) then
		gStateMachine:change('score', {
				score = self.score
			})
	end
	--update pipes list
	if lastPipeDistance() > pipe_offset then
		addPipe()
	end
	--update pipes pairs position 
	number_of_pipes = 0
	for k, pipes_pair in pairs(gPipes_pairs) do
		pipes_pair:updatePosition(dt)
		number_of_pipes = number_of_pipes + 1
		if gBird:collides(pipes_pair) then
			gStateMachine:change('score', {
				score = self.score
			})
		end
	end
	--remove the pipes pair on the left out of the update cycle otherwise glitch
	for k, pipes_pair in pairs(gPipes_pairs) do
		if pipes_pair:isOutL() then
			table.remove(pipes_pair, k)
		end
	end

	for k, pipes_pair in pairs(gPipes_pairs) do
		if not pipes_pair.scored then
			if gBird.x > (pipes_pair.pipe_bottom.x + pipes_pair.pipe_bottom.width) then
				self.score = self.score + 1 
				pipes_pair.scored = true
			end
		end
	end
end

function addPipe()
	gaps_difference = math.random(- y_max_gaps_difference, y_max_gaps_difference)
	gaps_difference = math.max(gaps_difference, -40)
	gaps_difference = math.min(gaps_difference, 40)
	new_y = last_gap_y + gaps_difference
	new_y = math.max(new_y, 30)
	new_y = math.min(new_y, virtual_height - 30)
	newPipesPair = PipesPair(pipe_image, virtual_width, new_y, 60)
	table.insert(gPipes_pairs, newPipesPair)
end

function lastPipeDistance()
	x_max = 0
	for k, pipes_pair in pairs(gPipes_pairs) do
		if pipes_pair.pipe_bottom.x > x_max then
			x_max = pipes_pair.pipe_bottom.x 
		end
	end
	return virtual_width - x_max
end

function PlayState:render()
	gBackground:render()
	gForeground:render()
	gBird:render()
	for k, pipes_pair in pairs(gPipes_pairs) do
		pipes_pair:render()
	end

	love.graphics.setFont(mediumFont)
	love.graphics.printf('Current score: ' .. tostring(self.score), 0, 5, virtual_width, 'center')
end


