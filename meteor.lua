Meteor = Class{}

function Meteor:init(pos, dir)
	self.img = love.graphics.newImage('graphics/meteorBig.png')
	self.pos = pos 
	self.vel = vector(0, 0)
	self.dir = dir
	self.speed = 300
	self.rot = 0
	self.rotSpeed = 1
end

function Meteor:update(dt)
	self.vel = self.dir * self.speed

	self.pos = self.pos + self.vel*dt

	self.rot = self.rot + self.rotSpeed *dt
end

function Meteor:draw()
	love.graphics.draw(self.img, self.pos.x, self.pos.y, self.rot, 1, 1, self.img:getWidth()/2, self.img:getHeight()/2)
end