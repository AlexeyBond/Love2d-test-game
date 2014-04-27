local class = require "bartbes.SECS.full"
local Layer = require "RakastettuLibs.Layer"
local texturedNode = require "RakastettuLibs.TexturedNode"


local num_side_nodes = 5;


local SpaceBGLayer = class:new()
SpaceBGLayer:addparent( Layer )

function SpaceBGLayer:init( texture, road_len )
	Layer.init( self )
	self._texture = texture
	self._road_len = road_len

	self._scale = 4.0

	local tw = texture:getWidth()
	local th = texture:getHeight()

	for i = 1, num_side_nodes do
		local yy = (num_side_nodes/2 - i)*tw
		for j = 1, num_side_nodes do
			local xx = (num_side_nodes/2 - j)*th
			self:addNode( texturedNode:new({x=xx,y=yy},nil,0,texture) )
		end
	end
end

function SpaceBGLayer:_applyTransforms( camera )
	local tw = self._texture:getWidth()
	local th = self._texture:getHeight()

	local trx = -(camera._originPt.x / self._road_len)*tw*10
	local try = -(camera._originPt.x / self._road_len)*th
	love.graphics.translate(camera._sizes.width/2, camera._sizes.height/2)
	love.graphics.scale(self._scale*camera._zoom/camera._zoom_aspect, self._scale*camera._zoom*camera._zoom_aspect)
	love.graphics.rotate(camera._angle * self._camera_move_scale.w)
	love.graphics.translate(trx%tw, try%th)
end

return SpaceBGLayer
