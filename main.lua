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
        drawable = true,
        damagable = { currHP = 3, maxHP = 3 }
    }
    
    local enemy = {
        position = { x = VIRTUAL_WIDTH / 2 + 40, y = VIRTUAL_HEIGHT / 2 },
        drawable = true,
        damagable = { currHP = 3, maxHP = 3 }
    }

    entities = {
        player,
        enemy
    }
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.update(dt)
    -- Timer.update(dt)
end

function love.draw()
    push:start()

    -- background
    love.graphics.setColor(216/255, 159/255, 34/255, 1)
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
    love.graphics.setColor(0, 0, 0, 1) -- reset color

    -- Draw all drawables
    local drawDrawables = System(
        { 'position', '-drawable' },
        function (pos)
            love.graphics.circle('fill', pos.x, pos.y, 5)
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
end
