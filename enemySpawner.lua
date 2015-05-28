EnemySpawner = Class{}

function EnemySpawner:init(pos, dir, minX, maxX)
	self.pos = pos
	self.dir = dir
	self.minX = minX
	self.maxX = maxX
	self.minTime = 0.5
	self.maxTime = 2.5
	self.timer = self.maxTime
end

function EnemySpawner:update(dt)
	self.timer = self.timer - (1 * dt)
	if self.timer <= 0 then
		local time = love.math.random() * self.maxTime + self.minTime
		self.timer = time
		
		local x = love.math.random(self.minX, self.maxX)
    	table.insert(enemies, Enemy(vector(x, self.pos.y), self.dir))
	end
end