Orden = Class:extend()
local anchoPantalla = love.graphics.getWidth()
local altoPatalla = love.graphics.getHeight()

    require "enemigo"
        require "meteoro"
    require "coin"

    SizeTypes = {"m", "mg", "b", "t"}
    MoveTypes = {"r", "r", "r", "r", "r", "r", "d", "di"}
    Velocidades = {50, 100, 150, 200, 300}

    function Orden:uno()
        print("aa")
        table.insert(MeteoroList, Meteoro(anchoPantalla + love.math.random(250,500), love.math.random(-250,altoPatalla+250), 100, "s", MoveTypes[love.math.random(1,8)]))
        table.insert(MeteoroList, Meteoro(anchoPantalla + love.math.random(250,500), love.math.random(-250,altoPatalla+250), 100, "s", MoveTypes[love.math.random(1,8)]))
        table.insert(MeteoroList, Meteoro(anchoPantalla + love.math.random(250,500), love.math.random(-250,altoPatalla+250), 100, "s", MoveTypes[love.math.random(1,8)]))
    end

    function Orden:dos ()
        print("bb")
        table.insert(MeteoroList, Meteoro(anchoPantalla + love.math.random(250,500), love.math.random(-250,altoPatalla+250), love.math.random(50,250), SizeTypes[love.math.random(1,4)], MoveTypes[love.math.random(1,8)]))
        table.insert(MeteoroList, Meteoro(anchoPantalla + love.math.random(250,500), love.math.random(-250,altoPatalla+250), love.math.random(50,250), SizeTypes[love.math.random(1,4)], MoveTypes[love.math.random(1,8)]))
        table.insert(MeteoroList, Meteoro(anchoPantalla + love.math.random(250,500), love.math.random(-250,altoPatalla+250), love.math.random(50,250), SizeTypes[love.math.random(1,4)], MoveTypes[love.math.random(1,8)]))
    end

    function Orden:Panel1()
        table.insert(CoinList, Coin(anchoPantalla + 50,  altoPatalla/2, 150, "s"))
        table.insert(CoinList, Coin(anchoPantalla + 150, altoPatalla/2 - 100, 150, "s"))
        table.insert(CoinList, Coin(anchoPantalla + 250, altoPatalla/2 + 100, 150, "s"))
        table.insert(CoinList,    Coin(anchoPantalla + 400, altoPatalla/2 + 40, 150, "s"))
        table.insert(MeteoroList, Meteoro(anchoPantalla + 400, altoPatalla/2 - 20, 150, "s", "r"))
    end

    function Orden:Panel2()
        table.insert(CoinList,    Coin(   anchoPantalla + 150, altoPatalla/2 - 150, 150, "s"))

        table.insert(MeteoroList, Meteoro(anchoPantalla + 100, altoPatalla/2 + 70, 150, "s", "r"))
        table.insert(MeteoroList, Meteoro(anchoPantalla + 200, altoPatalla/2,      150, "s", "r"))
        table.insert(MeteoroList, Meteoro(anchoPantalla + 300, altoPatalla/2 - 70, 150, "s", "r"))

        table.insert(CoinList,    Coin(   anchoPantalla + 150, altoPatalla/2 + 150, 150, "s"))
    end

    function Orden:Panel3()
        table.insert(MeteoroList, Meteoro(anchoPantalla-200,                   - 70, 150, "m", "d"))
        table.insert(MeteoroList, Meteoro(anchoPantalla-200 + 150, altoPatalla + 70, 150, "m", "di"))

        table.insert(MeteoroList, Meteoro(anchoPantalla-200 + 300,             - 70, 150, "m", "d"))
        table.insert(MeteoroList, Meteoro(anchoPantalla-200 + 450, altoPatalla + 70, 150, "m", "di"))

        table.insert(MeteoroList, Meteoro(anchoPantalla-200 + 600,             - 70, 150, "m", "d"))
        table.insert(MeteoroList, Meteoro(anchoPantalla-200 + 750, altoPatalla + 70, 150, "m", "di"))
    end

    function Orden:Panel4()
        table.insert(MeteoroList, Meteoro(anchoPantalla + 800,                 100, 170, "t", "r"))
        table.insert(MeteoroList, Meteoro(anchoPantalla + 700,                 90, 170, "t", "r"))
        table.insert(MeteoroList, Meteoro(anchoPantalla + 600,                 40, 170, "t", "r"))
        table.insert(MeteoroList, Meteoro(anchoPantalla + 810,                 70, 170, "t", "r"))
        table.insert(MeteoroList, Meteoro(anchoPantalla + 750,                 90, 170, "t", "r"))
        table.insert(MeteoroList, Meteoro(anchoPantalla + 530,                 100, 170, "t", "r"))
        table.insert(MeteoroList, Meteoro(anchoPantalla + 610,                 60, 170, "t", "r"))
        table.insert(MeteoroList, Meteoro(anchoPantalla + 770,                 50, 170, "t", "r"))
        table.insert(MeteoroList, Meteoro(anchoPantalla + 680,                 80, 170, "t", "r"))
        table.insert(MeteoroList, Meteoro(anchoPantalla + 900,                 100, 170, "t", "r"))
        table.insert(MeteoroList, Meteoro(anchoPantalla + 950,                 90, 170, "t", "r"))
        table.insert(MeteoroList, Meteoro(anchoPantalla + 1000,                 40, 170, "t", "r"))
        table.insert(MeteoroList, Meteoro(anchoPantalla + 970,                 70, 170, "t", "r"))
        table.insert(MeteoroList, Meteoro(anchoPantalla + 1200,                 90, 170, "t", "r"))
        table.insert(MeteoroList, Meteoro(anchoPantalla + 1050,                 100, 170, "t", "r"))
        table.insert(MeteoroList, Meteoro(anchoPantalla + 1300,                 60, 170, "t", "r"))
        table.insert(MeteoroList, Meteoro(anchoPantalla + 1250,                 50, 170, "t", "r"))
        table.insert(MeteoroList, Meteoro(anchoPantalla + 1100,                 80, 170, "t", "r"))
        table.insert(MeteoroList, Meteoro(anchoPantalla + 1150,                 90, 170, "t", "r"))
        table.insert(MeteoroList, Meteoro(anchoPantalla + 1080,                 100, 170, "t", "r"))
        table.insert(MeteoroList, Meteoro(anchoPantalla + 1260,                 60, 170, "t", "r"))
        table.insert(MeteoroList, Meteoro(anchoPantalla + 1240,                 50, 170, "t", "r"))
        table.insert(MeteoroList, Meteoro(anchoPantalla + 1350,                 80, 170, "t", "r"))
        table.insert(MeteoroList, Meteoro(anchoPantalla + 1740,                 50, 170, "t", "r"))
        table.insert(MeteoroList, Meteoro(anchoPantalla + 1650,                 80, 170, "t", "r"))
        table.insert(MeteoroList, Meteoro(anchoPantalla + 1550,                 50, 170, "t", "r"))
        table.insert(MeteoroList, Meteoro(anchoPantalla + 1680,                 80, 170, "t", "r"))
        table.insert(MeteoroList, Meteoro(anchoPantalla + 1680,                 100, 170, "t", "r"))
        table.insert(MeteoroList, Meteoro(anchoPantalla + 1350,                 90, 170, "t", "r"))
        table.insert(MeteoroList, Meteoro(anchoPantalla + 1600,                 40, 170, "t", "r"))
        table.insert(MeteoroList, Meteoro(anchoPantalla + 1770,                 70, 170, "t", "r"))
        table.insert(MeteoroList, Meteoro(anchoPantalla + 1420,                 90, 170, "t", "r"))

        table.insert(CoinList,    Coin(   anchoPantalla + 480, altoPatalla/2 -  30, 100, "s"))
        table.insert(CoinList,    Coin(   anchoPantalla + 450, altoPatalla/2 -  30, 100, "s"))
        table.insert(CoinList,    Coin(   anchoPantalla + 420, altoPatalla/2 -  30, 100, "s"))


        table.insert(MeteoroList, Meteoro(anchoPantalla + 480, altoPatalla/2 - 120, 100, "mg", "r"))
        table.insert(MeteoroList, Meteoro(anchoPantalla + 350, altoPatalla/2 -  60, 100, "mg", "r"))

        table.insert(MeteoroList, Meteoro(anchoPantalla + 680, altoPatalla/2, 100, "b", "r"))

        table.insert(MeteoroList, Meteoro(anchoPantalla + 350, altoPatalla/2 +  60, 100, "mg", "r"))
        table.insert(MeteoroList, Meteoro(anchoPantalla + 480, altoPatalla/2 + 120, 100, "mg", "r"))


        table.insert(CoinList,    Coin(   anchoPantalla + 420, altoPatalla/2 +  30, 100, "s"))
        table.insert(CoinList,    Coin(   anchoPantalla + 450, altoPatalla/2 +  30, 100, "s"))
        table.insert(CoinList,    Coin(   anchoPantalla + 480, altoPatalla/2 +  30, 100, "s"))


        table.insert(MeteoroList, Meteoro(anchoPantalla + 600,   altoPatalla - 100, 170, "t", "r"))
        table.insert(MeteoroList, Meteoro(anchoPantalla + 700,   altoPatalla - 100, 170, "t", "r"))
        table.insert(MeteoroList, Meteoro(anchoPantalla + 800,   altoPatalla - 100, 170, "t", "r"))

        table.insert(MeteoroList, Meteoro(anchoPantalla + 800,   altoPatalla - 950, 170, "t", "r"))
        table.insert(MeteoroList, Meteoro(anchoPantalla + 700,   altoPatalla - 90, 170, "t", "r"))
        table.insert(MeteoroList, Meteoro(anchoPantalla + 600,   altoPatalla - 40, 170, "t", "r"))
        table.insert(MeteoroList, Meteoro(anchoPantalla + 810,   altoPatalla - 70, 170, "t", "r"))
        table.insert(MeteoroList, Meteoro(anchoPantalla + 750,   altoPatalla - 90, 170, "t", "r"))
        table.insert(MeteoroList, Meteoro(anchoPantalla + 530,   altoPatalla - 100, 170, "t", "r"))
        table.insert(MeteoroList, Meteoro(anchoPantalla + 610,   altoPatalla - 60, 170, "t", "r"))
        table.insert(MeteoroList, Meteoro(anchoPantalla + 770,   altoPatalla - 50, 170, "t", "r"))
        table.insert(MeteoroList, Meteoro(anchoPantalla + 680,   altoPatalla - 80, 170, "t", "r"))
        table.insert(MeteoroList, Meteoro(anchoPantalla + 900,   altoPatalla - 100, 170, "t", "r"))
        table.insert(MeteoroList, Meteoro(anchoPantalla + 950,   altoPatalla - 90, 170, "t", "r"))
        table.insert(MeteoroList, Meteoro(anchoPantalla + 1000,  altoPatalla -  40, 170, "t", "r"))
        table.insert(MeteoroList, Meteoro(anchoPantalla + 970,   altoPatalla - 70, 170, "t", "r"))
        table.insert(MeteoroList, Meteoro(anchoPantalla + 1200,  altoPatalla -  90, 170, "t", "r"))
        table.insert(MeteoroList, Meteoro(anchoPantalla + 1050,  altoPatalla -  100, 170, "t", "r"))
        table.insert(MeteoroList, Meteoro(anchoPantalla + 1300,  altoPatalla -  60, 170, "t", "r"))
        table.insert(MeteoroList, Meteoro(anchoPantalla + 1250,  altoPatalla -  50, 170, "t", "r"))
        table.insert(MeteoroList, Meteoro(anchoPantalla + 1100,  altoPatalla -  80, 170, "t", "r"))
        table.insert(MeteoroList, Meteoro(anchoPantalla + 1150,  altoPatalla -  90, 170, "t", "r"))
        table.insert(MeteoroList, Meteoro(anchoPantalla + 1080,  altoPatalla -  100, 170, "t", "r"))
        table.insert(MeteoroList, Meteoro(anchoPantalla + 1460,  altoPatalla -  60, 170, "t", "r"))
        table.insert(MeteoroList, Meteoro(anchoPantalla + 1740,  altoPatalla -  50, 170, "t", "r"))
        table.insert(MeteoroList, Meteoro(anchoPantalla + 1650,  altoPatalla -  80, 170, "t", "r"))
        table.insert(MeteoroList, Meteoro(anchoPantalla + 1550,   altoPatalla - 50, 170, "t", "r"))
        table.insert(MeteoroList, Meteoro(anchoPantalla + 1680,   altoPatalla - 80, 170, "t", "r"))
        table.insert(MeteoroList, Meteoro(anchoPantalla + 1680,   altoPatalla - 100, 170, "t", "r"))
        table.insert(MeteoroList, Meteoro(anchoPantalla + 1350,   altoPatalla - 90, 170, "t", "r"))
        table.insert(MeteoroList, Meteoro(anchoPantalla + 1600,  altoPatalla -  40, 170, "t", "r"))
        table.insert(MeteoroList, Meteoro(anchoPantalla + 1770,   altoPatalla - 70, 170, "t", "r"))
        table.insert(MeteoroList, Meteoro(anchoPantalla + 1420,  altoPatalla -  90, 170, "t", "r"))
    end

    function Orden:Panel5()
        table.insert(CoinList, Coin(anchoPantalla + 150, altoPatalla/2 - 150, 150, "s"))
        table.insert(CoinList, Coin(anchoPantalla + 200, altoPatalla/2      , 150, "s"))
        table.insert(CoinList, Coin(anchoPantalla + 250, altoPatalla/2 + 150, 150, "s"))
    end

    function Orden:Panel6()
        table.insert(MeteoroList, Meteoro(anchoPantalla + 200,        altoPatalla, 100, "b", "r"))

        table.insert(CoinList, Coin(anchoPantalla + 270, altoPatalla - 170, 100, "s"))
        table.insert(CoinList, Coin(anchoPantalla + 380, altoPatalla - 20, 100, "s"))
        table.insert(CoinList, Coin(anchoPantalla + 380, altoPatalla - 80, 100, "s"))
        table.insert(CoinList, Coin(anchoPantalla + 520, altoPatalla - 210, 100, "s"))

        table.insert(CoinList, Coin(anchoPantalla + 540, altoPatalla/2, 100, "s"))
        table.insert(CoinList, Coin(anchoPantalla + 590, altoPatalla/2, 100, "s"))
        table.insert(CoinList, Coin(anchoPantalla + 640, altoPatalla/2, 100, "s"))
        table.insert(CoinList, Coin(anchoPantalla + 540, altoPatalla/2 - 50, 100, "s"))
        table.insert(CoinList, Coin(anchoPantalla + 590, altoPatalla/2 - 50, 100, "s"))
        table.insert(CoinList, Coin(anchoPantalla + 640, altoPatalla/2 - 50, 100, "s"))

        table.insert(CoinList, Coin(anchoPantalla + 720, altoPatalla - 150, 100, "s"))

        table.insert(MeteoroList, Meteoro(anchoPantalla + 300,                  0, 100, "b", "r"))
        table.insert(MeteoroList, Meteoro(anchoPantalla + 620,                 90, 100, "b", "r"))

        table.insert(MeteoroList, Meteoro(anchoPantalla + 380, altoPatalla/2 - 20, 100, "b", "r"))
        table.insert(MeteoroList, Meteoro(anchoPantalla + 580,   altoPatalla - 40, 100, "b", "r"))

        table.insert(MeteoroList, Meteoro(anchoPantalla + 800, altoPatalla/2, 100, "b", "r"))
    end