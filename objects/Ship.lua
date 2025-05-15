Ship = Object:extend()

function Ship:new(x, y, width, height, speed, tile, animations)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.speed = speed
    self.tile = tile
    self.animations = animations
end

function Ship:update(dt)
end

function Ship:draw()
end