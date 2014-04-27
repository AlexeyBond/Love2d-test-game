local class = require "bartbes.SECS.full"
local anim8 = require "anim8"
rkstlib.animatedNode = require "RakastettuLibs.AnimatedNode"

local Monster = class:new()
Monster:addparent(rkstlib.animatedNode)

function Monster:init(originPt, rect, angle, texture, road_texture, road_length)
	self._texture = texture
	self._w = texture:getWidth()
	self._h = texture:getHeight()
	local frameWidth =1
	local frameHeight =1
	local states = {}
	if texture == Game.textures.monster then
		frameWidth=210
		frameHeight=404
		local grid = anim8.newGrid(frameWidth, frameHeight, texture:getWidth(), texture:getHeight())
		states.walk = anim8.newAnimation('loop', grid('1-11,1'), 0.3)
		self._currentState = "walk"
	elseif texture == Game.textures.worm then 
		frameWidth=188
		frameHeight=188
		local grid = anim8.newGrid(frameWidth, frameHeight, texture:getWidth(), texture:getHeight())
		states.amam = anim8.newAnimation('loop', grid('1-6,1'), 0.3)
		self._currentState = "amam"
	end

	rkstlib.animatedNode.init(self, originPt, rect, angle, texture, frameWidth, frameHeight, states)

	self._originPt.x  = math.random(0.1, road_texture:getHeight()*road_length-0.1)
	self._originPt.y  = math.random(-road_texture:getWidth()/2,road_texture:getWidth()/2)
	local states = {}
	if texture == Game.textures.monster then
		local grid = anim8.newGrid(frameWidth, frameHeight, texture:getWidth(), texture:getHeight())
	elseif texture == Game.textures.worm then 
		local grid = anim8.newGrid(frameWidth, frameHeight, texture:getWidth(), texture:getHeight())
	end
	self._rect.top = self._h / 2
	self._rect.bottom = self._h / 2
	self._rect.left = self._w / 2
	self._rect.right = self._w / 2
end

return Monster