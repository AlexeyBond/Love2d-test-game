rkstlib.list = require "RakastettuLibs.List"

local Scene = {}

function Scene.new()
	print("Scene.new() called")

	local scene = {}

	scene._layers = rkstlib.list.new()

	scene._camera = {}
	local cam = scene._camera
	cam._originPt = {x = 0, y = 0}
	cam._sizes = {width = 0, height = 0}
	cam._angle = 0
	cam._zoom = 1
	cam._zoom_aspect = 1

	function scene:addLayer(layer)
		print("scene:addLayer(layer) called")
		self._layers:insert(layer)
	end

	function scene:draw()
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

	function scene:update(dt)

	end

	return scene
end

return Scene
