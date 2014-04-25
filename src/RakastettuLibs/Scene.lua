local class = require "bartbes.SECS.basic"
rkstlib.list = require "RakastettuLibs.List"

local Scene = class:new()

function Scene:init()
	self._layers = rkstlib.list:new()
	self._camera = {}

	local cam = self._camera
	cam._originPt = {x = 0, y = 0}
	cam._sizes = {width = 0, height = 0}
	cam._angle = 0
	cam._zoom = 1
	cam._zoom_aspect = 1
	cam._debug = true
end

function Scene:addLayer(layer)
	print("scene:addLayer(layer) called")
	self._layers:insert(layer)
end

function Scene:draw()
	if self._layers:isEmpty() then
		return
	end

	self._layers:toBegin()
	while true do
		local layer = self._layers:getCurrent()
		layer:draw(self._camera)
		if self._layers:isEnd() then
			break
		end
		self._layers:toNext()
	end
end

function Scene:update(dt)
end

return Scene
