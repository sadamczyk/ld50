require 'src/Dependencies'

function love.load()
    love.window.setTitle('Bombastic!')
    love.graphics.setDefaultFilter('nearest', 'nearest')
    math.randomseed(os.time())

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        vsync = true,
        resizable = true
    })
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.update(dt)
    -- Timer.update(dt)
end

function love.draw()
    push:start()

    -- Draw stuff here

    push:finish()
end
