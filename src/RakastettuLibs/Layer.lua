local class = require "bartbes.SECS.basic"
rkstlib.list = require "RakastettuLibs.List"

local Layer = class:new()

function Layer:init()
	self._nodes = rkstlib.list:new()

	--[[
		_camera_move_scale
		Мнеьше еденицы - слой движется при движении камеры медленее, 
		чем игровой мир(подхотит для бэкграунда), больше - движется быстрее.
		]]--
	self._camera_move_scale = { x = 1.0, y = 1.0, w = 1.0 }

	--[[
		_is_screen_overlay
		Если не false, то слой не реагирует на изменение положения камеры,
		что полезно для GUI.
		]]
	self._is_screen_overlay = false

	--[[
		_screen_overlay_size
		{x,y} - устанавливает размер экрана в системе координат слоя.
		]]
	self._screen_overlay_size = {width = 480, height = 320}
end


function Layer:addNode(node)
	print("Layer:addNode(node) called")
	self._nodes:insert(node)
end

function Layer:draw(camera)
	if self._nodes:isEmpty() then
		return
	end

	love.graphics.push()
	self:_applyTransforms( camera )

	self._nodes:toBegin()
	while true do
		local node = self._nodes:getCurrent()

		node:draw()

		if camera._debug == true then
			node:_debugDraw()
		end
		
		if self._nodes:isEnd() then
			break
		end
		self._nodes:toNext()
	end

	love.graphics.pop()
end

function Layer:_applyTransforms( camera )
	--[[
		Функция может быть перегружена, если система координат слоя
		не совпадает с системой координат игрового мира или экрана,
		что врядли.
		]]
	if self._is_screen_overlay == false then
		love.graphics.translate(camera._sizes.width/2, camera._sizes.height/2)
		love.graphics.scale(camera._zoom/camera._zoom_aspect, camera._zoom*camera._zoom_aspect)
		love.graphics.rotate(camera._angle * self._camera_move_scale.w)
		love.graphics.translate(
			-camera._originPt.x*self._camera_move_scale.x,
			-camera._originPt.y*self._camera_move_scale.y)
	else
		love.graphics.scale(
			camera._sizes.width/self._screen_overlay_size.width,
			camera._sizes.height/self._screen_overlay_size.height)
	end
end

function Layer:update(dt)
end

return Layer
