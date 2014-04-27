local class = require "bartbes.SECS.full"
rkstlib.texturedNode = require "RakastettuLibs.TexturedNode"

local Monster = class:new(); Monster:addparent(rkstlib.texturedNode)

function Monster:init(originPt, rect, angle, texture, road_texture, road_length)
	rkstlib.node.init(self, originPt, rect, math.pi/2)
	self._texture = texture
	self._w = texture:getWidth()
	self._h = texture:getHeight()
	self._originPt.x  = math.random(0.1, road_texture:getHeight()*road_length-0.1)
	self._originPt.y  = math.random(-road_texture:getWidth()/2,road_texture:getWidth()/2)
	self._rect.top = self._h / 2
	self._rect.bottom = self._h / 2
	self._rect.left = self._w / 2
	self._rect.right = self._w / 2
end

--function Monster:move(human_x)
	
return Monster