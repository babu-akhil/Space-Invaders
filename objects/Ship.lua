Ship = Object:extend()

function Ship:new(x, y, width, height,x_speed,y_speed, tile, animations)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.x_speed = x_speed
    self.y_speed = y_speed
    self.tile = tile
    self.animations = animations
end

function Ship:update(dt)
end

function Ship:draw()
end