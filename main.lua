require 'src/Dependencies'

function love.load()
    -- Basic setups
    love.window.setTitle('Bombastic!')
    love.graphics.setDefaultFilter('nearest', 'nearest')
    math.randomseed(os.time())

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        vsync = true,
        resizable = true
    })

    -- Create entities
    local player = {
        position = { x = VIRTUAL_WIDTH / 2, y = VIRTUAL_HEIGHT / 2 },
        drawable = { radius = 10 },
        damagable = { currHP = 3, maxHP = 3 },
        storage = { max = 2, curr = 0 }
    }
    
    local enemy = {
        position = { x = VIRTUAL_WIDTH / 2 + 100, y = VIRTUAL_HEIGHT / 2 },
        drawable = { radius = 10 },
        damagable = { currHP = 3, maxHP = 3 },
        storage = { max = 10, curr = 10 },
        AI = true
    }

    entities = {
        player,
        enemy
    }

    -- Start timers for throwing bombs
    Timer.every(5, function ()
        -- Create a new bomb entity
        local bomb = {
            position = { x = enemy.position.x, y = enemy.position.y },
            drawable = { radius = 2 },
            removable = false
        }

        table.insert(entities, #entities, bomb)

        -- Tween that new bomb to the player
        Timer.tween(5,  {
            [bomb.position] = { x = player.position.x, y = player.position.y }
        })
        :finish(function ()
            bomb.removable = true
        end)
    end)

    -- Removables
    removeEntities = System(
        { 'removable' },
        function (rem, entities, i)
            if rem then
                table.remove(entities, i)
            end
        end
    )
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.update(dt)
    for i = #entities, 1, -1 do
        removeEntities(entities[i], entities, i)
    end

    Timer.update(dt)
end

function love.draw()
    push:start()

    -- background
    love.graphics.setColor(216/255, 159/255, 34/255, 1)
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
    love.graphics.setColor(0, 0, 0, 1) -- reset color

    love.graphics.setFont(gFonts['small'])
    love.graphics.print(#entities, 20, 20)

    -- Draw all drawables
    local drawDrawables = System(
        { 'position', 'drawable' },
        function (pos, drawable)
            love.graphics.circle('fill', pos.x, pos.y, drawable.radius)
        end
    )

    for _, entity in ipairs(entities) do
        drawDrawables(entity)
    end

    push:finish()
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end

    -- select target
    if key == 'up' or key == 'down' or key == 'left' or key == 'right' then
        
    -- throw bomb
    elseif key == 'enter' then

    -- dodge bomb
    elseif key == 'shift' then

    -- catch bomb
    elseif key == 'space' then
        
    end
end
