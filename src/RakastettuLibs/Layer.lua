local Layer = {}

function Layer.new()
	print("Layer.new() called")

	local layer = {}

	function layer:draw(camera)

	end

	function layer:update(dt)

	end

	return layer
end

return Layer