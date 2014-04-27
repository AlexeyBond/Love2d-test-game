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
	self._v = 0
	self._maxv = 0.1
end

return Player
