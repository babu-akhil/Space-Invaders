Ship = Object:extend()

function Ship:new(x, y, width, height, speed)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.speed = speed
end

function Ship:update(dt)
end

function Ship:draw()
end