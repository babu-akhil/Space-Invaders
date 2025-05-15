PlayerShip = Ship:extend()

function PlayerShip:new(x, y, width, height, x_speed, y_speed, tile, animations)
    PlayerShip.super.new(self, x, y, width, height, x_speed, y_speed, tile, animations)
    self.bullets = {}
    self.fire_sound = love.audio.newSource('sounds/laser.wav', 'static')
    self.bullet_img = love.graphics.newImage('images/bullet_basic.png')
end

function PlayerShip:fire()
    if self.cooldown <= 0 then
        love.audio.play(self.fire_sound)
        self.cooldown = 20
        bullet = Bullet(self.x + self.width/2 - bullet_width/2, self.y - bullet_height/2, bullet_width, bullet_height, 600, self.bullet_img)
        table.insert(self.bullets, bullet)
    end
end

function PlayerShip:update(dt)
    PlayerShip.super.update(self, dt)
    if love.keyboard.isDown("right") then
        self.x = self.x + self.x_speed * dt
        self.x_velocity = self.x_speed
    elseif love.keyboard.isDown("left") then
        self.x = self.x - self.x_speed * dt
        self.x_velocity = -self.x_speed
    else
        self.x_velocity = 0
    end

    if love.keyboard.isDown("up") then
        self.y_velocity = -self.y_speed
        self.y= self.y - self.y_speed * dt
    elseif love.keyboard.isDown("down") then
        self.y_velocity = self.y_speed
        self.y= self.y + self.y_speed * dt
    end

    for i,b in ipairs(self.bullets) do
		if b.y < -10 then
			table.remove(self.bullets,i)
		end	
		b:update(dt)
	end
end

function PlayerShip:draw()
    PlayerShip.super.draw(self)
    if self.x_velocity > 0 then
        self.animations.right:draw(self.tile, self.x, self.y, 0, 4, 4)
    elseif self.x_velocity < 0 then
        self.animations.left:draw(self.tile, self.x, self.y, 0, 4, 4)
    else
        self.animations.idle:draw(self.tile, self.x, self.y, 0, 4, 4)
    end
    for _,b in pairs(self.bullets) do
        b:draw()
    end
    if draw_hitbox then
        love.graphics.setColor(255,0,0)
        love.graphics.rectangle('line', self.x, self.y, self.width, self.height)
        love.graphics.setColor(255,255,255)
    end
end