io.stdout:setvbuf('no')

function love.load()
    Class = require 'class'
    vector = require 'vector'
    camera = require 'camera'
    require 'menu'
    require 'game'
    require 'player'
    require 'enemy'
    require 'bullet'
    require 'cannon'
    require 'meteor'
    require 'meteorSpawner'
    require 'enemySpawner'
    require 'collision'
    require 'circleCollider'
    require 'particle'
    require 'tableSaver'

    smallFont = love.graphics.newFont('fonts/ArcadeClassic.ttf', 20)
    averageFont = love.graphics.newFont('fonts/ArcadeClassic.ttf', 40)
    bigFont = love.graphics.newFont('fonts/ArcadeClassic.ttf', 60)

    state = 'menu'

    scoreTable, err = table.load("highscore.txt")
    if err then 
        scoreTable = {}
        print(err)
    end

    if state == 'menu' then 
        menu_load()
    elseif state == 'game' then 
        game_load()
    end
end

function love.update(dt)
    if state == 'menu' then 
        menu_update(dt)
    elseif state == 'game' then 
        game_update(dt)
    end
end

function love.draw()
    if state == 'menu' then 
        menu_draw()
    elseif state == 'game' then 
        game_draw()
    end
end

function love.keypressed(key, unicode)
    if state == 'game' then 
        game_keypressed(key, unicode)
    end
end

function love.quit()
    table.save(scoreTable, "highscore.txt")
end