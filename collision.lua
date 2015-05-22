function collision_load()
	colliders = {}
end

function collision_update(dt)
	for i, c in pairs(colliders) do
		if c.parent.destroy == true then 
			colliders[i] = nil
		end 

		c:update(dt)

        if c.pos.y < -offY or c.pos.y > love.window.getHeight() + offY then 
            colliders[i] = nil
        end
	end 

	for i1, c1 in pairs(colliders) do 
		for i2, c2 in pairs(colliders) do
			if c1 ~= c2 and isColliding(c1, c2) then
				c1:collision(c2.parent)
			end 
		end
	end 
end

function collision_draw()
	for i, c in pairs(colliders) do
		c:draw()
	end 
end

function isColliding(c1, c2)
	local dx = c1.pos.x - c2.pos.x 
	local dy = c1.pos.y - c2.pos.y 

	local dis = math.sqrt(dx^2 + dy^2)

	return dis < c1.r + c2.r
end