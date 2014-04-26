local class = require "bartbes.SECS.full"
local Layer = require "RakastettuLibs.Layer"

local roadlayer_num_nodes = 5;


local RoadLayer = class:new()
RoadLayer:addparent( Layer )

function RoadLayer:init( roadTexture )
	Layer.init( self )
	self._texture = roadTexture

	local tw = roadTexture:getWidth()
	local th = roadTexture:getHeight()


end

function RoadLayer:_applyTransforms( camera )
	love.graphics.translate(camera._sizes.width/2, camera._sizes.height/2)
	love.graphics.scale(camera._zoom/camera._zoom_aspect, camera._zoom*camera._zoom_aspect)
	love.graphics.rotate(camera._angle * self._camera_move_scale.w)
	love.graphics.translate(
		(-camera._originPt.x*self._camera_move_scale.x)%(self._texture:getWidth()),
		-camera._originPt.y*self._camera_move_scale.y)
end

return RoadLayer