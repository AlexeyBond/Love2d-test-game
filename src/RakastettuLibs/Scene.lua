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

	function scene:addLayer(layer)
		print("scene:addLayer(layer) called")
	end

	function scene:draw()

	end

	function scene:update(dt)

	end

	return scene
end

return Scene