Bullet = Object:extend()

function Bullet:new(x, y, width, height, speed, img)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.speed = speed
    self.img = img
end

function Bullet:update(dt)
    self.y = self.y - self.speed * dt
end

function Bullet:draw()
    love.graphics.draw(self.img, self.x, self.y,0, 4, 4)
    if draw_hitbox then
        love.graphics.setColor(255,0,0)
        love.graphics.rectangle('line', self.x, self.y, self.width, self.height)
        love.graphics.setColor(255,255,255)
    end
end