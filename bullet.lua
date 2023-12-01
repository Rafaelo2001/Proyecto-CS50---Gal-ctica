Bullet = Class:extend()

function Bullet:new(x,y, type)
    self.x = x
    self.y = y

    if type == "l1" then
        self.image = love.graphics.newImage("assets/nave/bullet - laser1.png")
        self.speed = 400
        self.damage = 1
        self.rango = 400
    elseif type == "l2" then
        self.image = love.graphics.newImage("assets/nave/bullet - laser2.png")
        self.speed = 800
        self.damage = 3
        self.rango = 550
    end

    self.ancho = self.image:getWidth()
    self.alto = self.image:getHeight()

    self.radioHitbox = self.ancho/2
end

function Bullet:checkColision(e)
    local distancia = math.sqrt(
        ((self.x + 5 + self.ancho*2) - e.x)^2 + (self.y - e.y)^2
    )

    if self.radioHitbox + e.radioHitbox > distancia then
        return true
    end

    return false
end

function Bullet:update(dt)
    self.x = self.x + self.speed * dt
end

function Bullet:draw()
    love.graphics.draw(self.image, self.x,self.y, math.pi/2, 1,1, self.ancho/2, self.alto/2)

    love.graphics.circle("line", self.x + 5 + self.ancho*2, self.y, self.radioHitbox)
end