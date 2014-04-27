local class = require "bartbes.SECS.full"
rkstlib.node = require "RakastettuLibs.Node"
local anim8 = require "anim8"

local AnimatedNode = class:new(); AnimatedNode:addparent(rkstlib.node)

function AnimatedNode:init(originPt, rect, angle, texture, frameWidth, frameHeight, states)
	rkstlib.node.init(self, originPt, rect, angle)
	self._texture = texture

	--self._grid = grid
	self._states = states

	self._w = frameWidth
	self._h = frameHeight
	print(self._h)
	self._rect.top = self._h / 2
	self._rect.bottom = self._h / 2
	self._rect.left = self._w / 2
	self._rect.right = self._w / 2
end

function AnimatedNode:setState(state_name)
	if self._states[state_name] ~= nil then
		self._currentState = state_name
	else
		error("Error at AnimatedNode:setState(state_name)")
		error("State '" .. state_name .."' does not exist")
	end
end

function AnimatedNode:draw()
	if self._currentState then
		love.graphics.setColor(255, 255, 255, 255)
		love.graphics.push( )
		love.graphics.translate( self._originPt.x, self._originPt.y )
		love.graphics.rotate( self._angle )

		if love.window then --будет работать в 9 версии
			self._states[self._currentState]:draw(self._texture, -self._rect.left, -self._rect.top)
		end

		love.graphics.pop();
	end
end

function AnimatedNode:update(dt)
	self._states[self._currentState]:update(dt)
end

return AnimatedNode
