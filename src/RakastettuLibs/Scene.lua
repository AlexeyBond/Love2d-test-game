local Scene = {}

function Scene.new()
	print("Scene.new() called")

	local scene = {}

	scene._layers = {}

	scene._camera = {}
	local cam = scene._camera
	cam._originPt = {x = 0, y = 0}
	cam._sizes = {width = 0, height = 0}
	cam._angle = 0
	cam._debug = true -- Enable debug drawing

	scene._layers = dofile("List.lua").new()

	function scene:addLayer(layer)
		print("scene:addLayer(layer) called")
		self._layers.insertAtBegin(layer)
	end

	function scene:draw()
		self._layers.toBegin()
		local layer

		while (layer = self._layers.getCurrent()) ~= nil do
			layer.draw(self._camera)
			self._layers.toNext( )
		end
	end

	function scene:update(dt)

	end

	return scene
end

return Scene