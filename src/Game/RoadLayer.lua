local class = require "bartbes.SECS.full"
local Layer = require "RakastettuLibs.Layer"
local texturedNode = require "RakastettuLibs.TexturedNode"

local roadlayer_num_nodes = 5;


local RoadLayer = class:new()
RoadLayer:addparent( Layer )

function RoadLayer:init( roadTexture )
	Layer.init( self )
	self._texture = roadTexture

	local tw = roadTexture:getWidth()
	local th = roadTexture:getHeight()

	for i = 1, roadlayer_num_nodes do
		local xx = (roadlayer_num_nodes/2 - i+2)*th
		self:addNode( texturedNode:new({x=xx,y=0},nil,math.pi/2,roadTexture) )
	end
end

function RoadLayer:_applyTransforms( camera )
	love.graphics.translate(camera._sizes.width/2, camera._sizes.height/2)
	love.graphics.scale(camera._zoom/camera._zoom_aspect, camera._zoom*camera._zoom_aspect)
	love.graphics.rotate(camera._angle * self._camera_move_scale.w)
	love.graphics.translate(
		-((camera._originPt.x*self._camera_move_scale.x)%(self._texture:getHeight())),
		-camera._originPt.y*self._camera_move_scale.y)
end

return RoadLayer