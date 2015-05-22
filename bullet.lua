Bullet = Class{}

function Bullet:init(pos, dir)
	self.img = love.graphics.newImage('graphics/bullet.png')
	self.pos = pos 
	self.vel = vector(0, 0)
	self.dir = dir
	self.speed = 800
end

function Bullet:update(dt)
	self.vel = self.dir * self.speed

	self.pos = self.pos + self.vel*dt
end 

function Bullet:draw()
	love.graphics.draw(self.img, self.pos.x, self.pos.y, 0, 1, 1, self.img:getWidth()/2, self.img:getHeight()/2)
end