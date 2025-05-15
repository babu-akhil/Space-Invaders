Ship = Object:extend()

function Ship:new(x, y, width, height,x_speed,y_speed, tile, animations, type, explode_tile, cooldown)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.x_speed = x_speed
    self.y_speed = y_speed
    self.tile = tile
    self.animations = animations
    self.cooldown = cooldown
    if type == 'player' then
        self.type = 1
    elseif type == 'enemy' then
        self.type = -1
    end
    self.bullets = {}
    self.bullet_img = love.graphics.newImage('images/bullet_basic.png')
    self.fire_sound = love.audio.newSource('sounds/laser.wav', 'static')
    self.explode_tile = explode_tile
    self.explode_grid = anim8.newGrid(8, 8,self.explode_tile:getWidth(), self.explode_tile:getHeight())
    self.animations.explode = anim8.newAnimation(self.explode_grid('10-13', 7), 0.1)
    self.explode = false
    self.explode_timer = 10
    self.explode_sound = love.audio.newSource('sounds/Boom15.wav', 'static')
end

function Ship:fire()
    if self.cooldown <= 0 then
        love.audio.play(self.fire_sound)
        self.cooldown = 20
        bullet = Bullet(self.x + self.width/2 - bullet_width/2, self.y - self.type*bullet_height/2, bullet_width, bullet_height, self.type*600, self.bullet_img)
        table.insert(self.bullets, bullet)
    end
end

function Ship:update(dt)
    self.cooldown = self.cooldown - 1
    for i,b in ipairs(self.bullets) do
		if b.y < -10 then
			table.remove(self.bullets,i)
        elseif b.y > love.graphics.getHeight() then
            table.remove(self.bullets,i)
        else
            b:update(dt)
        end
	end
    if self.explode then
        self.explode_timer = self.explode_timer - 1
        self.animations.explode:update(dt)
    end
end

function Ship:draw()
    if draw_hitbox then
        love.graphics.setColor(255,0,0)
        love.graphics.rectangle('line', self.x, self.y, self.width, self.height)
        love.graphics.setColor(255,255,255)
    end
    for _,b in pairs(self.bullets) do
        b:draw()
    end
end