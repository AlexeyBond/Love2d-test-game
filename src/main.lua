function love.load()
	local width = 128
	local height = 128

	if love.window ~= nil then
		love.window.setMode(width, height)
	else
		love.graphics.setMode(width, height)
	end
end


function love.draw()

end


function love.update(dt)

end
