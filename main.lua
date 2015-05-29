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

--http://stackoverflow.com/questions/15706270/sort-a-table-in-lua
function spairs(t, order)
    -- collect the keys
    local keys = {}
    for k in pairs(t) do keys[#keys+1] = k end

    -- if order function given, sort by it by passing the table and keys a, b,
    -- otherwise just sort the keys 
    if order then
        table.sort(keys, function(a,b) return order(t, a, b) end)
    else
        table.sort(keys)
    end

    -- return the iterator function
    local i = 0
    return function()
        i = i + 1
        if keys[i] then
            return keys[i], t[keys[i]]
        end
    end
end