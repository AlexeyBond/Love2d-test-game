local class = require "bartbes.SECS.basic"

local Node = class:new()

function Node:init()
	self._rect = {
		top = 0,
		bottom = 0,
		left = 0,
		right = 0
	}

	self._originPt = {x = 0, y = 0}
	self._angle = 0
end

function Node:draw()
end

function Node:setRect(top, bottom, left, right)
	self._rect = {
		top = top,
		bottom = bottom,
		left = left,
		right = right
	}
end

function Node:rotate( dangle )
	self._angle = self._angle+dangle
end

function Node:rotateTo( angle )
	self._angle = angle
end

function Node:_debugDraw()
	love.graphics.push( )
	love.graphics.translate( self._originPt.x, self._originPt.y )
	love.graphics.rotate( self._angle )
	love.graphics.setColor(200, 80, 80, 20)
	love.graphics.rectangle("fill", -self._rect.left, -self._rect.top,
		self._rect.left+self._rect.right, self._rect.top+self._rect.bottom)
	love.graphics.setColor(200, 80, 80, 200)
	love.graphics.rectangle("line", -self._rect.left, -self._rect.top,
		self._rect.left+self._rect.right, self._rect.top+self._rect.bottom)
	love.graphics.setColor(255, 120, 120, 255)
	love.graphics.setLineWidth(0.2)
	local cross_size = 2
	love.graphics.line(cross_size, cross_size, -cross_size, -cross_size)
	love.graphics.line(cross_size, -cross_size, -cross_size, cross_size)
	love.graphics.pop( );
end

function Node:move(dx, dy)
	self._originPt.x = self._originPt.x + dx
	self._originPt.y = self._originPt.y + dy
end


function Node:moveTo(x, y)
	self._originPt.x = x
	self._originPt.y = y
end

return Node
