local class = require "bartbes.SECS.full"
rkstlib.texturedNode = require "RakastettuLibs.TexturedNode"

local Player = class:new(); Player:addparent(rkstlib.texturedNode)

function Player:init(originPt, rect, angle, texture)
	rkstlib.node.init(self, originPt, rect, angle)
	self._texture = texture
	self._w = texture:getWidth()
	self._h = texture:getHeight()
	self._rect.top = self._h / 2
	self._rect.bottom = self._h / 2
	self._rect.left = self._w / 2
	self._rect.right = self._w / 2
end

function Player:draw()
	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.push( )
	love.graphics.translate( self._originPt.x, self._originPt.y )
	love.graphics.rotate( self._angle )
	love.graphics.draw(self._texture, self._originPt.x - self._rect.left, self._originPt.y - self._rect.top)
	love.graphics.pop( );
end

return Player
