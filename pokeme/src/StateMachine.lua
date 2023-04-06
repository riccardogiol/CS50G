StateMachine = Class{}

function StateMachine:init(states)
	self.states = states or {}
	self.currentState = BaseState()
end

function StateMachine:update(dt)
	self.currentState:update(dt)
end

function StateMachine:change(stateName, enterParams)
	assert(self.states[stateName])
	self.currentState:exit()
	self.currentState = self.states[stateName]()
	self.currentState:enter(enterParams)
end

function StateMachine:render()
	self.currentState:render()
end