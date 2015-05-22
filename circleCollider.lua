CircleCollider = Class{}

function CircleCollider:init(radius, parent, offX, offY)
	self.r = radius
	self.pos = parent.pos
	self.parent = parent
	self.offX = offX
	self.offY = offY
	table.insert(colliders, self)
end

function CircleCollider:update(dt)
	self.pos = self.parent.pos
end

function CircleCollider:draw()
	love.graphics.circle('line', self.pos.x, self.pos.y, self.r, 100)
end

function CircleCollider:collision(obj)
	self.parent:hit(obj)
end