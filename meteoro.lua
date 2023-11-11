Meteoro = Enemigo:extend()

function Meteoro:new(x,y, speed, imagen)
    Meteoro.super.new(self, x,y, imagen)
    self.speed = speed
    self.rotacion = 0
end

function Meteoro:update(nave, dt)
    self.rotacion = self.rotacion + dt / 2
    self.x = self.x + - self.speed * dt
    self.y = self.y - - self.speed * dt

    -- Revision de coliciones de la nave
    if self.super.checkColision(self,nave) then
        print("meteoro-choca-nave")
    end
end

function Meteoro:draw()
    love.graphics.draw(self.imagen, self.x,self.y, self.rotacion, 1,1, self.ancho/2,self.alto/2)
    love.graphics.circle("line", self.x,self.y, self.radioHitbox)
end