local class = require "bartbes.SECS.full"
rkstlib.texturedNode = require "RakastettuLibs.TexturedNode"

local Barrel = class:new()
Barrel:addparent(rkstlib.texturedNode)

function Barrel:init( texture, minx, maxx )
	rkstlib.texturedNode.init(
		self,
		{x=math.random(minx,maxx), y=math.random(-100,100)},
		null, 0, texture)
	self._radius = (texture:getHeight()+texture:getWidth())*0.25
	self._alive = true
end

function Barrel:draw( )
	if self._alive then
		rkstlib.texturedNode.draw( self )
	end
end

function Barrel:_debugDraw()
	love.graphics.push( )
	love.graphics.translate( self._originPt.x, self._originPt.y )
	love.graphics.rotate( self._angle )
	love.graphics.setColor(200, 80, 80, 20)
	love.graphics.rectangle("fill", -self._rect.left, -self._rect.top,
		self._rect.left+self._rect.right, self._rect.top+self._rect.bottom)
	love.graphics.setColor(200, 80, 80, 200)
	love.graphics.rectangle("line", -self._rect.left, -self._rect.top,
		self._rect.left+self._rect.right, self._rect.top+self._rect.bottom)
	love.graphics.circle("line", 0,0, self._radius, 100)
	love.graphics.setColor(255, 120, 120, 255)
	love.graphics.setLineWidth(0.2)
	local cross_size = 2
	love.graphics.line(cross_size, cross_size, -cross_size, -cross_size)
	love.graphics.line(cross_size, -cross_size, -cross_size, cross_size)
	love.graphics.pop( );
end

return Barrel
