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

game_controller = {}
game_controller.enemies = {}
game_controller.player = {}
game_controller.game_over = false
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
	game_controller.player = PlayerShip(10, 450, 32, 32, 150, 150, player_tile, player_animations, explode_tile, 20)

	-- enemy properties
	enemy_tile = love.graphics.newImage('SpaceShooterAssets/SpaceShooterAssetPack_Ships.png')
	enemy_grid = anim8.newGrid(8, 8, enemy_tile:getWidth(), enemy_tile:getHeight())
	enemy_animations = {}
	enemy_animations.idle = anim8.newAnimation(enemy_grid('6-6', 1), 0.1)
	enemy_animations.explode = explode_animation
	game_controller:spawnEnemy(love.graphics.getWidth()/2-50,0)
	game_controller:spawnEnemy(love.graphics.getWidth()/2+50,0)
	
end

--Section 1.3 		
--colen passes self else use function fuction_name(self)
function game_controller:spawnEnemy(x,y)

	--Section 1.3.1	
	enemy = EnemyShip(x,y, 32, 32, 100, 30, enemy_tile, explode_tile, enemy_animations, 40)
	table.insert(self.enemies, enemy)

end

--Section 3
function game_controller:checkCollisions(bullets)
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

function check_player_collisions(bullets)
	for i, b in ipairs(bullets) do
		if b.y <= game_controller.player.y + game_controller.player.height and b.y >= game_controller.player.y and b.x > game_controller.player.x and b.x < game_controller.player.x + game_controller.player.width then
			game_controller.player.explode = true
			table.remove(bullets, i)
			love.audio.play(game_controller.player.explode_sound)
		end
	end
end

--Section 2
function love.update(dt)
	game_controller.player:update(dt)
	if love.keyboard.isDown("space")then
		game_controller.player:fire()
	end

	--Section 2.3
	for i,e in ipairs(game_controller.enemies) do
		e:update(dt)
		if e.explode and e.explode_timer <= 0 then
			table.remove(game_controller.enemies, i)
			print('enemy dead')
		else
			check_player_collisions(e.bullets)
		end
	end
	if game_controller.player.explode and game_controller.player.explode_timer <= 0 then
		table.remove(game_controller, player)
		print('player dead')
		game_controller.game_over = true
	else
		game_controller:checkCollisions(game_controller.player.bullets)
	end
end


--Section 4
function love.draw()
	--Section 4.1
	love.graphics.setColor(255,255,255)
	if not game_controller.game_over then
		game_controller.player:draw()
	end
	--Section 4.2 first is rotation , width height ,skew
	love.graphics.setColor(255,255,255)
	for _,e in pairs(game_controller.enemies) do
		e:draw()
	end
end
