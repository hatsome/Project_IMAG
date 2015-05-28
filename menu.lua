function menu_load()
	selectedIndex = 1
	menuTime = 0
end

function menu_update(dt)
	menuTime = menuTime + (1*dt)

	if love.keyboard.isDown('w') then 
		selectedIndex = 1
	elseif love.keyboard.isDown('s') then 
		selectedIndex = 2
	elseif menuTime > 0.5 and love.keyboard.isDown(' ') then 
		if selectedIndex == 1 then 
			state = 'game'
			game_load()
		else 
			love.event.quit()
		end
	end
end

function menu_draw()
	local r, g, b, a = love.graphics.getColor()
    love.graphics.setColor(238, 210, 2, 255)

    love.graphics.setFont(bigFont)
    love.graphics.printf('Project IMAG', 0, love.window.getHeight()/4, love.window.getWidth(),'center')

    love.graphics.setFont(averageFont)
    love.graphics.printf('Play', 0, love.window.getHeight()/4 +200, love.window.getWidth(),'center')

    love.graphics.printf('Exit', 0, love.window.getHeight()/4 +250, love.window.getWidth(),'center')

	local pointerX, pointerY
    if selectedIndex == 1 then 
    	pointerX = love.window.getWidth()/2 -50
    	pointerY = love.window.getHeight()/4 +220
    else
    	pointerX = love.window.getWidth()/2 -50
    	pointerY = love.window.getHeight()/4 +270
    end
    love.graphics.polygon('fill', pointerX -10, pointerY -10, pointerX -10, pointerY +10, pointerX, pointerY)

    love.graphics.setFont(smallFont)

    local offset = 400
    for name, score in pairs(scoreTable) do 
    	love.graphics.printf(name, 0, love.window.getHeight()/4 +offset, love.window.getWidth()/4*1.9,'right')
    	love.graphics.printf(score, 0, love.window.getHeight()/4 +offset, love.window.getWidth()/4*2.2,'right')
    	offset = offset + 20
    end

    love.graphics.setColor(r, g, b, a)
end