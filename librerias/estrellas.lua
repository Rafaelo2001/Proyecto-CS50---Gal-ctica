local tickStar = require "librerias.tick"
local pantalla = {}
pantalla.ancho = love.graphics.getWidth()
pantalla.alto = love.graphics.getHeight()
-- 720 x 600

function StarLoad()
    Estrellas0 = {}
    Estrellas1 = {}
    Estrellas2 = {}
    Min_estrellas = 1
    Max_estrellas = 250

    for i = 1, Max_estrellas*3 do
        local x = love.math.random(5, pantalla.ancho * 3)
        local y = love.math.random(5, pantalla.alto - 5)

        Estrellas0[i] = {x, y}
    end

    tickStar.recur(
        function ()
            for min = Min_estrellas, Max_estrellas do
                local x = love.math.random(pantalla.ancho, pantalla.ancho * 2)
                local y = love.math.random(5, pantalla.alto - 5)

                Estrellas2[min] = {x, y}
            end
        end
    , 23)

    tickStar.delay(function ()

        tickStar.recur(
            function ()
                for min = Min_estrellas, Max_estrellas do
                local  x = love.math.random(pantalla.ancho, pantalla.ancho * 2)
                    local y = love.math.random(5, pantalla.alto - 5)

                    Estrellas1[min] = {x, y}
                end
            end
        , 23)

    end, 12)

end

function StarUpdate(dt)
    --tickStar.update(dt)

    for i, v in ipairs(Estrellas0) do
        v[1] = v[1] - 70*dt
    end
    for i, v in ipairs(Estrellas1) do
        v[1] = v[1] - 70*dt
    end
    for i, v in ipairs(Estrellas2) do
        v[1] = v[1] - 70*dt
    end

    for i, v in ipairs(Estrellas0) do
        if v[1] < 0 then
            table.remove(Estrellas0, i)
        end
    end
end

function StarDraw()
    love.graphics.points(Estrellas0)
    love.graphics.points(Estrellas1)
    love.graphics.points(Estrellas2)
end