Cannon = Class{}

function Cannon:init(dir, maxTime, parent, offX, offY, bulImg, bulType, bulScale)
	self.pos = parent.pos
	self.dir = dir
	self.parent = parent
	self.offX = offX
	self.offY = offY
	self.maxTime = maxTime
	self.timer = self.maxTime
	self.canShoot = false
	self.bulImg = bulImg
	self.bulType = bulType
	self.bulScale = bulScale
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
		table.insert(bullets, Bullet(self.bulType, self.pos, self.dir, self.bulImg, self.bulScale))
		self.canShoot = false
		self.timer = self.maxTime
	end
end