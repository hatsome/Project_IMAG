function game_load()
    points = 0
    timePoints = 0
    time = 0
    offY = 200
    enemies = {}
    bullets = {}
    meteors = {}
    particles = {}
    gameOver = false

    camPos = vector(love.window.getWidth()/2, love.window.getHeight()/2)
    cam = camera(camPos.x, camPos.y)
    shakePos = {}

    collision_load()
    player = Player(vector(love.window.getWidth()/2, 950))
    enemySpawner = EnemySpawner(vector(love.window.getWidth()/2, -offY), vector(0, 1), 0, love.window.getWidth())
    meteorSpawner = MeteorSpawner(vector(love.window.getWidth()/2, -offY), vector(0, 1), 100, love.window.getWidth()-100)
end

function game_update(dt)
    for i, bullet in pairs(bullets) do 
        bullet:update(dt)

        if bullet.destroy or bullet.pos.y < -offY or bullet.pos.y > love.window.getHeight() + offY then
            bullets[i] = nil
        end
    end

    if player then 
        player:update(dt)

        if player.destroy then
            player = nil 
        end

        time = time + (1 *dt)
        timePoints = math.floor(time)*10
    end 

    meteorSpawner:update(dt)

    for i, meteor in pairs(meteors) do 
        meteor:update(dt)

        if meteor.destroy or meteor.pos.y < -offY or meteor.pos.y > love.window.getHeight() + offY then 
            meteors[i] = nil
        end
    end

    enemySpawner:update(dt)

    for i, enemy in pairs(enemies) do 
        enemy:update(dt)

        if enemy.destroy or enemy.pos.y < -offY or enemy.pos.y > love.window.getHeight() + offY then 
            enemies[i] = nil 
        end 
    end

    collision_update(dt)

    for i, particle in pairs(particles) do
        particle:update(dt)

        if particle.destroy or particle.pos.y < -offY or particle.pos.y > love.window.getHeight() + offY then 
            particles[i] = nil
        end
    end

    local pos = table.remove(shakePos, 1)
    if pos then 
        cam:lookAt(pos.x, pos.y)
    end 

    if gameOver then
        if not scoreTable[username] or scoreTable[username] < timePoints+points then 
            scoreTable[username] = timePoints+points
        end

        if love.keyboard.isDown('r') then 
            game_load()
        end
    end
end

function game_draw()
    cam:draw(game_drawWorld)
    game_drawHUD()
end

function game_drawHUD()
    local r, g, b, a = love.graphics.getColor()
    love.graphics.setColor(238, 210, 2, 255)
    love.graphics.setFont(smallFont)

    love.graphics.printf(timePoints + points, love.window.getWidth(), 0, 0,'right', 0, 1, 1, 15, -10)

    if gameOver then
        love.graphics.setFont(bigFont)
        love.graphics.printf('Game Over', 0, love.window.getHeight()/2, love.window.getWidth(),'center')
    end

    love.graphics.setColor(r, g, b, a)
end

function game_drawWorld()
    for i, particle in pairs(particles) do
        particle:draw()
    end

    if player then 
        player:draw()
    end

    for i, meteor in pairs(meteors) do 
        meteor:draw()
    end

    for i, enemy in pairs(enemies) do 
        enemy:draw()
    end

    for i, bullet in pairs(bullets) do 
        bullet:draw()
    end 

    --collision_draw()
end

function game_shakeCam(diffX, diffY, times)
    camShakeTime = time
    for i=1,times do 
        local m = (love.math.random() > 0.5) and -1 or 1  
        shakePos[i] = {x= camPos.x + love.math.random(0, diffX)*m , y = camPos.y + love.math.random(0, diffY)*m}
    end 
    shakePos[times+1] = { x = camPos.x, y = camPos.y }
end