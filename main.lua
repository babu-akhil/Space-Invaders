--Author: Akhil Babu (forked from Mrinal Pande's repo)
--imports

anim8 = require('libraries/anim8')
Object = require('libraries/classic')

-- objects
require('objects/Ship')
require('objects/Bullet')
require('objects/PlayerShip')
require('objects/EnemyShip')
--min max
love.graphics.setDefaultFilter('nearest','nearest')

enemies_controller = {}
enemies_controller.enemies ={}
draw_hitbox = false

--Section 1 
function love.load()
    
	-- global bullet properties

	bullet_width = 4
	bullet_height = 8
	bullet_img = love.graphics.newImage('images/bullet_basic.png')

	-- explode animation
	explode_tile = love.graphics.newImage('SpaceShooterAssets/SpaceShooterAssetPack_Miscellaneous.png')

	-- player properties
	player_tile = love.graphics.newImage('SpaceShooterAssets/SpaceShooterAssetPack_Ships.png')
	player_grid = anim8.newGrid(8, 8, player_tile:getWidth(), player_tile:getHeight())
	player_animations = {}
	player_animations.idle = anim8.newAnimation(player_grid('2-2', 1), 0.1)
	player_animations.right = anim8.newAnimation(player_grid('3-3', 1), 0.1)
	player_animations.left = anim8.newAnimation(player_grid('1-1', 1), 0.1)
	player_animations.explode = explode_animation
	player = PlayerShip(10, 450, 32, 32, 150, 150, player_tile, player_animations)
	player.cooldown = 20

	-- enemy properties
	enemy_tile = love.graphics.newImage('SpaceShooterAssets/SpaceShooterAssetPack_Ships.png')
	enemy_grid = anim8.newGrid(8, 8, enemy_tile:getWidth(), enemy_tile:getHeight())
	enemy_animations = {}
	enemy_animations.idle = anim8.newAnimation(enemy_grid('6-6', 1), 0.1)
	enemy_animations.explode = explode_animation
	enemies_controller:spawnEnemy(love.graphics.getWidth()/2-50,0)
	enemies_controller:spawnEnemy(love.graphics.getWidth()/2+50,0)
	
end

--Section 1.3 		
--colen passes self else use function fuction_name(self)
function enemies_controller:spawnEnemy(x,y)

	--Section 1.3.1	
	enemy = EnemyShip(x,y, 32, 32, 100, 30, enemy_tile, explode_tile, enemy_animations)
	table.insert(self.enemies, enemy)

end

--Section 3
function enemies_controller:checkCollisions(bullets)
	for i, e in ipairs(self.enemies) do
	    for _, b in ipairs(bullets) do
			if b.y <= e.y + e.height and b.y >= e.y and b.x > e.x and b.x < e.x + e.width then
				e.explode = true
				table.remove(bullets, _)
				love.audio.play(e.explode_sound)
			end
	    end
	end
end

--Section 2
function love.update(dt)
	player.cooldown= player.cooldown - 1
	player:update(dt)
	if love.keyboard.isDown("space")then
		player:fire()
	end

	--Section 2.3
	for i,e in ipairs(enemies_controller.enemies) do
		e:update(dt)
		if e.explode and e.explode_timer <= 0 then
			table.remove(enemies_controller.enemies, i)
			print('enemy dead')
		end
	end
	enemies_controller:checkCollisions(player.bullets)
end


--Section 4
function love.draw()
	--Section 4.1
	love.graphics.setColor(255,255,255)

	player:draw()
	--Section 4.2 first is rotation , width height ,skew
	love.graphics.setColor(255,255,255)
	for _,e in pairs(enemies_controller.enemies) do
		e:draw()
	end
end
