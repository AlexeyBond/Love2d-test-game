local class = require "bartbes.SECS.full"

local Node = class:new()

function Node:init(originPt, rect, angle)
	if rect then
		self._rect = rect
	else
		self._rect = {
			top = 0,
			bottom = 0,
			left = 0,
			right = 0
		}
	end

	if originPt then
		self._originPt = originPt
	else
		self._originPt = {
			x = 0,
			y = 0
		}
	end

	if angle then
		self._angle = angle
	else
		self._angle = math.pi/2
	end
end

function Node:setOriginPt(x, y)
	if type(x) == "table" then
		self._originPt = x
	else
		self._originPt = {
			x = x,
			y = y
		}
	end
end

function Node:getOriginPt()
	return {
		x = self._originPt.x,
		y = self._originPt.y
	}
end

function Node:draw()
end

function Node:update(dt)
end

function Node:setRect(top, bottom, left, right) --можно вызывать :setRect(rect)
	if type(top) == "table" then
		self._rect = top
	else
		self._rect = {
			top = top,
			bottom = bottom,
			left = left,
			right = right
		}
	end
end

function Node:getRect() -- возвращает копию _rect
	return {
		top = self._rect.top,
		bottom = self._rect.bottom,
		left = self._rect.left,
		right = self._rect.right
	}
end

function Node:rotate( dangle )
	self._angle = self._angle+dangle
end

function Node:rotateTo( angle )
	self._angle = angle
end

function Node:getAngle()
	return self._angle
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

function Node:vector_move(vert, hor)
	self._originPt.x = self._originPt.x + vert*math.sin(self._angle)
	self._originPt.y = self._originPt.y - vert*math.cos(self._angle)
	self._originPt.x = self._originPt.x + hor*math.cos(self._angle)
	self._originPt.y = self._originPt.y + hor*math.sin(self._angle)
end

return Node
