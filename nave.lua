Nave = Class:extend()

function Nave:new(x, y, vidas, damage, speed)
    self.x = x
    self.y = y
    self.vidas = vidas
    self.damage = damage
    self.speed = speed

    self.skin = love.graphics.newImage("assets/nave/nave1.png")
    self.ancho = self.skin:getWidth()
    self.alto = self.skin:getHeight()
    self.rotacion = - math.pi / 2
    self.desgarroX = 0
    self.desgarroY = 0

    self.radioHitbox = self.ancho/2 - 10
end

function Nave:checkColision(e)
    local distancia = math.sqrt(
        (self.x - e.x)^2 + (self.y - e.y)^2
    )

    if self.radioHitbox + e.radioHitbox > distancia then
        return true
    end

    return false
end

function Nave:reciveDano(e, dt)
    if self:checkColision(e) then
        print("nave-choca-meteoro")
        self.vidas = self.vidas - 1
    end
end

function Nave:update(dt)
    -- Movimiento de la nave
        if love.keyboard.isDown("d", "right") then
            self.x = self.x + self.speed * dt
        elseif love.keyboard.isDown("a", "left") then
            self.x = self.x - self.speed * dt
        end

        if love.keyboard.isDown("s", "down") then
            self.y = self.y + 600 * dt
            self.desgarroX = -0.1
        elseif love.keyboard.isDown("w", "up") then
            self.y = self.y - 600 * dt
            self.desgarroX =  0.1
        else
            self.desgarroX = 0
        end


    -- Desplazamiento automatico a la posicion base
        if self.x > 151 then
            self.x = self.x - 30 * dt
        elseif self.x < 149 then
            self.x = self.x + 30 * dt
        end

        if self.y < 69 then
            self.y = self.y + 30 * dt
        elseif self.y > love.graphics.getHeight() - 69 then
            self.y = self.y - 30 * dt
        end

    -- Limitacion de movimiento al alrea de la pantalla visible
        if self.x <= 20 then
            self.x = 20
        elseif self.x >= 600 then
            self.x = 600
        end

        if self.y <=  40 then
            self.y = 40
        elseif self.y >= love.graphics.getHeight() - 40 then -- Cambiar esa funcion si se llega a notar lento
            self.y = love.graphics.getHeight() - 40
        end
end

function Nave:drawLife()
    -- Calculos para la barra de vida
    local iniciobar = love.graphics.newImage("assets/nave/livebar-start.png")
    local anchoI = iniciobar:getWidth()

    local middlebar = love.graphics.newImage("assets/nave/livebar-middle.png")
    local anchoM = middlebar:getWidth()

-- Barra de Vida
    love.graphics.print("vida " .. self.vidas, 0,20)
    love.graphics.draw(love.graphics.newImage("assets/nave/livebar-start.png"), 30,20, 0, 1,1, 0,0, 0,0)
    love.graphics.draw(love.graphics.newImage("assets/nave/livebar-middle.png"), 30 + anchoI,20, 0, self.vidas/9,1, 0,0, 0,0)
    love.graphics.draw(love.graphics.newImage("assets/nave/livebar-end.png"), anchoM * self.vidas/9 + 30 + anchoI,20, 0, 1,1, 0,0, 0,0)
end

function Nave:draw()
    love.graphics.print("x " .. self.x, self.x+50,self.y+50)
    love.graphics.print("y " .. self.y, self.x+50,self.y+70)
    love.graphics.draw(
        self.skin,
        self.x,
        self.y,
        self.rotacion,
        1,1,
        self.ancho/2,
        self.alto/2,
        self.desgarroX,self.desgarroY
    )

    -- Prototipo Hitbox (28 se resta de lado y lado, 14 para volverlo a centrar)
    -- love.graphics.rectangle("line", self.x - self.alto / 2, self.y - self.ancho/2 + 14, self.alto,self.ancho-28)
    love.graphics.circle("line", self.x,self.y, self.radioHitbox)
end