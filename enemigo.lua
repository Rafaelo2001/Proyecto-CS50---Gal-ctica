Enemigo = Class:extend()

function Enemigo:new(x, y, imagen)
    self.x = x
    self.y = y

    self.imagen = love.graphics.newImage(imagen)
    self.ancho = self.imagen:getWidth()
    self.alto = self.imagen:getHeight()

    self.radioHitbox = self.ancho/2 - 5
end

function Enemigo:checkColision(e)
    local distancia = math.sqrt(
        (self.x - e.x)^2 + (self.y - e.y)^2
    )

    if self.radioHitbox + e.radioHitbox > distancia then
        return true
    end

    return false
end

function Enemigo:draw()
    -- love.graphics.draw(self.imagen, self.x,self.y)
end