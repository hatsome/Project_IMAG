Cannon = Class{}

function Cannon:init(dir, parent, offX, offY)
	self.pos = parent.pos
	self.dir = dir
	self.parent = parent
	self.offX = offX
	self.offY = offY
	self.maxTime = 0.1
	self.timer = self.maxTime
	self.canShoot = false
end

function Cannon:update(dt)
	self.pos = vector(self.parent.pos.x + self.offX, self.parent.pos.y + self.offY)

	self.timer = self.timer - (1 * dt)
	if self.timer <= 0 then
		self.canShoot = true
	end
end

function Cannon:shoot()
	if self.canShoot then
		table.insert(bullets, Bullet(self.pos, self.dir))
		self.canShoot = false
		self.timer = self.maxTime
	end
end