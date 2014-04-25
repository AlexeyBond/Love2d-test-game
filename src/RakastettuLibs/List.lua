local class = require "bartbes.SECS.basic"

local List = class:new()

function List:init()
	self._head = nil
	self._tail = nil
	self._current = nil
	self._byID = {}
end

function List:insert(newElem)
	local cur = {value = newElem}
	if self._head == nil then
		self._head = cur
		self._tail = self._head
		self._current = self._head
	else
		cur.prev = self._current
		cur.next = self._current.next
		self._current.next = cur
		if cur.next ~= nil then
			cur.next.prev = cur
		else
			self._tail = cur
		end
	end

	if type(newElem.id) == "string" or type(newElem.id) == "number" then
		if self._byID[newElem.id] == nil then
			self._byID[newElem.id] = newElem
		else
			error("Error at List:insert(newElem)")
			error("Duplicate IDs: " .. newElem.id)
			error("List pointer: " .. self)
		end
	end
end

function List:insertAtBegin(newElem)
	if self:isEmpty() then
		self:insert(newElem)
	else
		local tmp = {}
		tmp.next = self._head
		local cur = self._current
		self._current = tmp
		self._head = tmp
		self:insert(newElem)
		self:toBegin()
		self:removeCurrent()
		self._current = cur
	end
end

function List:removeCurrent()
	local cur = self._current
	if cur ~= nil then
		if cur.prev ~= nil then
			cur.prev.next = cur.next
		else
			self._head = cur.next
		end

		if cur.next ~= nil then
			cur.next.prev = cur.prev
			self._current = cur.next
		else
			self._tail = cur.prev
			self._current = cur.prev
		end

		if type(cur.value.id) == "string" or type(cur.value.id) == "number" then
			self._byID[cur.value.id] = nil
		end
	end
end

function List:removeById(id)
	if self._byID[id] ~= nil then
		if self._current.value == self._byID[id] then
			self:removeCurrent()
		else
			local it = self._head
			while it do
				if it.value == self._byID[id] then
					local cur = self._current
					self._current = it
					self:removeCurrent()
					self._current = cur
					return
				end
			end

			error("Error at List:removeById(id)")
			error("ID exist but not found at list: " .. id)
			error("List pointer: " .. self)
		end
	end
end

function List:getCurrent()
	if self._current ~= nil then
		return self._current.value
	else
		return nil
	end
end

function List:toBegin()
	self._current = self._head
end

function List:toEnd()
	self._current = self._tail
end

function List:toNext()
	if self._current then
		self._current = self._current.next
	end
end

function List:toPrev()
	if self._current then
		self._current = self._current.prev
	end
end

function List:isEmpty()
	if self._head then
		return false
	else
		return true
	end
end

function List:isEnd()
	if self._current then
		if self._current.next then
			return false
		end
	end
	return true
end

return List
