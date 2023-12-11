love.window.setTitle("Project Galáctica")

local tick = require "librerias.tick"
local anchoPantalla = love.graphics.getWidth()
local altoPatalla = love.graphics.getHeight()
-- 720 x 600

function love.load()
    -- 0 - Start Screen
    -- 1 - Game Screen
    -- 2 - Game Over Screen
    GameState = 0
    Class = require "librerias.classic"

    require "librerias.estrellas"
    require "nave"
    require "bullet"
    require "enemigo"
        require "meteoro"
    require "coin"
    require "meteorosDisplay"

    Player = Nave(200, altoPatalla/2, 300, 500, 300)
    OrdenM = Orden()
    Score = 0
    Balas = {}

    StarLoad()

    MaxMeteo = 3
    MeteoroList = {}

    SizeTypes = {"m", "mg", "b", "t", "s"}
    MoveTypes = {"r", "r", "r", "r", "r", "r", "d", "di"}



    local maxCoin = 20
    CoinList = {}

    -- OrdenM:Panel6()

    -- todo bien
    MetoeGroup = tick.group()

    MetoeGroup:delay(function () OrdenM:Panel1() end,0)
    MetoeGroup:delay(
        function ()
            OrdenM:Panel2()
        end,
        4
    )
    MetoeGroup:delay(
        function ()
            OrdenM:Panel3()
        end,
        8
    )
    MetoeGroup:delay(
        function ()
            OrdenM:Panel6()
        end,
        10
    )
    MetoeGroup:delay(
        function ()
            OrdenM:Panel4()
        end,
        18
    )

    MetoeGroup:delay(
        function ()
            print("meteo ult1")
            tick.recur(
                function ()
                    OrdenM:uno()
                    OrdenM:dos()
                end
                ,
                love.math.random(0.4,1.2)
            )
            end
        , 26
    )

    MetoeGroup:delay(
        function ()
            print("meteo ult2")
            tick.recur(
                function ()
                    table.insert(MeteoroList, Meteoro(anchoPantalla + love.math.random(250,500), love.math.random(-250,altoPatalla+250), love.math.random(50,250), SizeTypes[love.math.random(1,2)], MoveTypes[love.math.random(1,3)]))
                    table.insert(MeteoroList, Meteoro(anchoPantalla + love.math.random(250,500), love.math.random(-250,altoPatalla+250), love.math.random(50,250), SizeTypes[love.math.random(1,2)], MoveTypes[love.math.random(1,3)]))
                    table.insert(MeteoroList, Meteoro(anchoPantalla + love.math.random(250,500), love.math.random(-250,altoPatalla+250), love.math.random(50,250), SizeTypes[love.math.random(1,2)], MoveTypes[love.math.random(1,3)]))
                end
                ,
                love.math.random(0.4,1.2)
            )
        end
        , 40
    )

    -- Fuentes
    Fuente = love.graphics.newFont("assets/font/kenvector_future.ttf")
    GOFont = love.graphics.newFont("assets/font/kenvector_future.ttf", 35)

    Logo = love.graphics.newImage("assets/main_logo.png")
end

function love.keypressed(key)
    if GameState == 0 and key == "space" then
        GameState = 1
        print("ao")
    elseif GameState == 1 then
        if Score < 1500 then
            if #Balas < 7 then
                if key == "z" or key == "return" then
                    table.insert(Balas, Bullet(Player.x, Player.y, "l1"))
                end
            end
        elseif Score >= 1500 and Score < 3000 then
            if #Balas < 11 then
                if key == "z" or key == "return" then
                    table.insert(Balas, Bullet(Player.x, Player.y, "l2"))
                end
            end
        elseif Score >= 3000  then
            if #Balas < 15 then
                if key == "z" or key == "return" then
                    table.insert(Balas, Bullet(Player.x, Player.y, "l3"))
                end
            end
        end
    end
end

function love.update(dt)
    tick.update(dt)
    StarUpdate(dt)

    if GameState == 0 then
        -- Incluir pantalla de inicio
    elseif GameState == 1 then
        MetoeGroup:update(dt)

        Player:update(dt)

        -- Actualizamos la posicion de cada bala
        for i, v in ipairs(Balas) do
            v:update(dt)

            for j, m in ipairs(MeteoroList) do
                if v:checkColision(m) then
                    m.vida = m.vida - v.damage
                    table.remove(Balas, i)
                    if m.vida <= 0 then
                        Score = Score + m.value
                        table.remove(MeteoroList, j)
                        table.remove(Balas, i)
                    end
                end
            end

            -- Calcula la distancia maxima antes de eliminar el disparo
            local distancia_nave = v.rango + Player.x
            if v.x > distancia_nave then
                table.remove(Balas, i)
            end
        end

        for i, v in ipairs(MeteoroList) do
            v:update(dt)
            Player:reciveDano(v, dt)

            if Player.vidas <= 0 then
                GameState = 2
            end
        end

        for i, c in ipairs(CoinList) do
            c:update(dt)

            if Player:checkColision(c) then
                Score = Score + c.value
                table.remove(CoinList, i)
            end
        end

        --  Eliminacion de objetos mas alla de la pantalla
        for i, v in ipairs(MeteoroList) do
            if v.x < -anchoPantalla or v.y < -altoPatalla or v.y > altoPatalla*2 then
                table.remove(MeteoroList, i)
            end
        end

        for i, v in ipairs(CoinList) do
            if v.x < -anchoPantalla then
                table.remove(CoinList, i)
            end
        end

    elseif GameState == 2 then
    end
end

function love.draw()
    StarDraw()
    if GameState == 0 then
        love.graphics.draw(Logo, anchoPantalla/2, 200, 0, 0.5,0.5, Logo:getWidth()/2, Logo:getHeight()/2)
    elseif GameState == 1 then

        love.graphics.print("Score: " .. Score, Fuente, anchoPantalla - 100)

        -- Dibujamos cada bala
        for i, v in ipairs(Balas) do
            v:draw()
        end

        -- Se dibuja al player de ultima para que aparezca encima de las balas
        Player:draw()

        for i, v in ipairs(MeteoroList) do
            v:draw()
        end

        for i, c in ipairs(CoinList) do
            c:draw()
        end

        Player:drawLife()

    elseif GameState == 2 then
        love.graphics.printf("GAME OVER",             GOFont, 0, altoPatalla/2 - 35, anchoPantalla, "center")
        love.graphics.printf("Your Score: " .. Score, Fuente, 0, altoPatalla/2,      anchoPantalla, "center")
    end
end