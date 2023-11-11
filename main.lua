function love.load()
    Class = require "librerias.classic"

    require "nave"
    require "bullet"

    Player = Nave(200, 200, 3, 500, 300)
    Balas = {}

    Fuente = love.graphics.newFont("assets/font/kenvector_future.ttf")
end

function love.keypressed(key)
    if key == "z" or key == "return" then
        table.insert(Balas, Bullet(Player.x, Player.y))
    end
end

function love.update(dt)
    Player:update(dt)

    -- Actualizamos la posicion de cada bala
    for i, v in ipairs(Balas) do
        v:update(dt)

        -- Calcula la distancia maxima antes de eliminar el disparo
        local distancia_nave = v.rango + Player.x
        if v.x > distancia_nave then
            table.remove(Balas, i)
        end
    end
end

function love.draw()
    love.graphics.print("Hola", Fuente, 10)

    -- Dibujamos cada bala
    for i, v in ipairs(Balas) do
        v:draw()
    end

    -- Se dibuja al player de ultima para que aparezca encima de las balas
    Player:draw()
end