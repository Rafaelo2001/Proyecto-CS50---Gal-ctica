Bullet = Class:extend()

function Bullet:new(x,y)
    self.x = x
    self.y = y

    self.image = love.graphics.newImage("assets/nave/bullet - laser1.png")
    self.ancho = self.image:getWidth()
    self.alto = self.image:getHeight()

    self.speed = 600
    self.damage = 5
    self.rango = 400
end

function Bullet:update(dt)
    self.x = self.x + self.speed * dt
end

function Bullet:draw()
    love.graphics.draw(self.image, self.x,self.y, math.pi/2, 1,1, self.ancho/2, self.alto/2)
end