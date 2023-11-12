Enemigo = Class:extend()

function Enemigo:new(x, y, imagen)
    self.x = x
    self.y = y

    self.imagen = love.graphics.newImage(imagen)
    self.ancho = self.imagen:getWidth()
    self.alto = self.imagen:getHeight()

    self.radioHitbox = self.ancho/2 - 5
end



function Enemigo:update()
    
end

function Enemigo:draw()
    -- love.graphics.draw(self.imagen, self.x,self.y)
end