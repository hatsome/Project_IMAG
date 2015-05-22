Meteor = Class{}

function Meteor:init(pos, dir)
	self.type = 'enemy'
	self.img = love.graphics.newImage('graphics/meteorBig.png')
	self.pos = pos 
	self.vel = vector(0, 0)
	self.dir = dir
	self.speed = 300
	self.rot = 0
	self.rotSpeed = 1
	self.c = CircleCollider(50, self, 0, 0)
	self.live = 3
	self.destroy = false
end

function Meteor:update(dt)
	self.vel = self.dir * self.speed

	self.pos = self.pos + self.vel*dt

	self.rot = self.rot + self.rotSpeed *dt

	if self.live <= 0 then 
		self.destroy = true
	end
end

function Meteor:draw()
	love.graphics.draw(self.img, self.pos.x, self.pos.y, self.rot, 1, 1, self.img:getWidth()/2, self.img:getHeight()/2)
end

function Meteor:hit(obj)
	if obj.type == 'bullet' then
		self.live = self.live -1
	end
end