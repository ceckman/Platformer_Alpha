require "lua/AnAL"
require "lua/TEsound"
Camera = require "lua/camera"
Gamestate = require "lua/gamestate"
Menu = require 'lua/menu'
Timer = require "lua/timer"

--Create our gamestates (ie levels, menu)
local menu = {}
local game = {}

function love.load()
	Gamestate.registerEvents() -- so state:update() will get called
    Gamestate.switch(menu)
end

function menu:init()
   TEsound.playLooping("menu/maintheme.mp3", "main")
   mbk = love.graphics.newImage("menu/m_bk.jpg")
   testmenu = Menu.new()
   testmenu:addItem{
      name = 'Start Game',
      action = function()
		 TEsound.stop("main")
         Gamestate.switch(game)
      end
   }
   testmenu:addItem{
      name = 'Options',
      action = function()
         --nothing doing
      end
   }
   testmenu:addItem{
      name = 'Quit',
      action = function()
         love.event.push('quit')
      end
	}
   love.graphics.setMode(1024, 768, false, true, 0) --set the window dimensions to 1024 by 768
end
function menu:update(dt)
   testmenu:update(dt)
end

function menu:draw()
   love.graphics.draw(mbk, 0, 0)
   love.graphics.setColor(255, 0, 0, 255)
   love.graphics.print("PLATFORMER ALPHA", 250, 100, 0, 2, 2)
   testmenu:draw(250, 250)
end

function menu:keypressed(key)
   testmenu:keypressed(key)
end

yc = -9000
change = 0
jump = false
jumping = false
left = false
right = false
standing = true
air = false
up = false
mid = false
down = false
walking= false
first = true
dead = false
bup = false
bup2 = false
bup3 = false

function game:init()
	local img  = love.graphics.newImage("MAFRE/running.png")
	local img2  = love.graphics.newImage("MAFRE/runningbetterleft.png")
	local death = love.graphics.newImage("MAFRE/dying.png")
	bk = love.graphics.newImage("level1/bk1.png")
   --image, frame width, frame height, fps
   anim = newAnimation(img, 93, 75, .15, 0)
   --choose either loop, bounce, or once for setMode
   anim:setMode("loop")
   
   imageStanding = love.graphics.newImage("MAFRE/standingbetter.png")
   imageStandingLeft = love.graphics.newImage("MAFRE/standingleft.png")
   
   imageJumpingUp = love.graphics.newImage("MAFRE/jumpingup.png")
   imageJumpingDown = love.graphics.newImage("MAFRE/jumpingdown.png")
   
   imageJumpingUpLeft = love.graphics.newImage("MAFRE/jumpingupleft.png")
   imageJumpingDownLeft = love.graphics.newImage("MAFRE/jumpingdownleft.png")
   
   
   anim2 = newAnimation(img2, 93, 75, .15, 0)
   anim2:setMode("loop")
   
   anim_dead = newAnimation(death, 110, 88, .1, 0)
   anim_dead:setMode("loop")

	--The background music, set to .3 its normal volume
    TEsound.playLooping("level1/level1.mp3")
   
	text = " "
	love.physics.setMeter(100) --the height of a meter our worlds will be 64px
	world = love.physics.newWorld(0, 9.81*64, true) --create a world for the bodies to exist in with horizontal gravity of 0 and vertical gravity of 9.81
	
	world:setCallbacks(beginContact, endContact, preSolve, postSolve)

	
	objects = {} -- table to hold all our physical objects

	objects.player = {}
	objects.player.body = love.physics.newBody(world, 40, 100, "dynamic")
	objects.player.shape = love.physics.newRectangleShape(80, 65)
	objects.player.fixture = love.physics.newFixture(objects.player.body, objects.player.shape)
	objects.player.body:setFixedRotation(true)
	
	cam = Camera(objects.player.body:getX(), objects.player.body:getY())
	
	objects.block1 = {}
	objects.block1.body = love.physics.newBody(world, 0, 350, "kinematic")
	objects.block1.shape = love.physics.newRectangleShape(0, 0, 400, 100)
	objects.block1.fixture = love.physics.newFixture(objects.block1.body, objects.block1.shape, 5)

	objects.block2 = {}
	objects.block2.body = love.physics.newBody(world, 600, 300, "kinematic")
	objects.block2.shape = love.physics.newRectangleShape(0, 0, 200, 200)
	objects.block2.fixture = love.physics.newFixture(objects.block2.body, objects.block2.shape, 2)
	
	objects.block3 = {}
	objects.block3.body = love.physics.newBody(world, 500, 500, "kinematic")
	objects.block3.shape = love.physics.newRectangleShape(0, 0, 100, 300)
	objects.block3.fixture = love.physics.newFixture(objects.block3.body, objects.block3.shape, 5)
	
	objects.block4 = {}
	objects.block4.body = love.physics.newBody(world, -300, 0, "kinematic")
	objects.block4.shape = love.physics.newRectangleShape(0, 0, 600, 1000)
	objects.block4.fixture = love.physics.newFixture(objects.block4.body, objects.block4.shape, 5)
	
	objects.block5 = {}
	objects.block5.body = love.physics.newBody(world, 800,-300, "kinematic")
	objects.block5.shape = love.physics.newRectangleShape(0, 0, 2000, 600)
	objects.block5.fixture = love.physics.newFixture(objects.block5.body, objects.block5.shape, 5)
	
	objects.block6 = {}
	objects.block6.body = love.physics.newBody(world, 500,400, "kinematic")
	objects.block6.shape = love.physics.newRectangleShape(0, 0, 1000, 100)
	objects.block6.fixture = love.physics.newFixture(objects.block6.body, objects.block6.shape, 5)
	
	objects.block7 = {}
	objects.block7.body = love.physics.newBody(world, 950, 300, "kinematic")
	objects.block7.shape = love.physics.newRectangleShape(0, 0, 102, 200)
	objects.block7.fixture = love.physics.newFixture(objects.block7.body, objects.block7.shape, 2)
	
	objects.block8 = {}
	objects.block8.body = love.physics.newBody(world, 1700, 700, "kinematic")
	objects.block8.shape = love.physics.newRectangleShape(0, 0, 1000, 2000)
	objects.block8.fixture = love.physics.newFixture(objects.block8.body, objects.block8.shape, 2)
	
	objects.block9 = {}
	objects.block9.body = love.physics.newBody(world, 800, 900, "kinematic")
	objects.block9.shape = love.physics.newRectangleShape(0, 0, 1200, 200)
	objects.block9.fixture = love.physics.newFixture(objects.block9.body, objects.block9.shape, 2)
	
	objects.block10 = {}
	objects.block10.body = love.physics.newBody(world, 700, 500, "kinematic")
	objects.block10.shape = love.physics.newRectangleShape(0, 0, 100, 300)
	objects.block10.fixture = love.physics.newFixture(objects.block10.body, objects.block10.shape, 5)
	
	objects.block11 = {}
	objects.block11.body = love.physics.newBody(world, 900, 500, "kinematic")
	objects.block11.shape = love.physics.newRectangleShape(0, 0, 100, 300)
	objects.block11.fixture = love.physics.newFixture(objects.block11.body, objects.block11.shape, 5)
	
	objects.block12 = {}
	objects.block12.body = love.physics.newBody(world, 300, 500, "kinematic")
	objects.block12.shape = love.physics.newRectangleShape(0, 0, 100, 300)
	objects.block12.fixture = love.physics.newFixture(objects.block12.body, objects.block12.shape, 5)
	
	objects.block13 = {}
	objects.block13.body = love.physics.newBody(world, 0, 650, "kinematic")
	objects.block13.shape = love.physics.newRectangleShape(0, 0, 200, 50)
	objects.block13.fixture = love.physics.newFixture(objects.block13.body, objects.block13.shape, 5)
	
	objects.block14 = {}
	objects.block14.body = love.physics.newBody(world, -500, 0, "kinematic")
	objects.block14.shape = love.physics.newRectangleShape(0, 0, 300, 2000)
	objects.block14.fixture = love.physics.newFixture(objects.block14.body, objects.block14.shape, 5)
	
	objects.block15 = {}
	objects.block15.body = love.physics.newBody(world, 50, 975, "kinematic")
	objects.block15.shape = love.physics.newRectangleShape(0, 0, 300, 50)
	objects.block15.fixture = love.physics.newFixture(objects.block15.body, objects.block15.shape, 5)
	
	objects.block16 = {}
	objects.block16.body = love.physics.newBody(world, -80, 900, "kinematic")
	objects.block16.shape = love.physics.newRectangleShape(0, 0, 50, 200)
	objects.block16.fixture = love.physics.newFixture(objects.block16.body, objects.block16.shape, 5)
	
	objects.block17 = {}
	objects.block17.body = love.physics.newBody(world, -300, 1300, "kinematic")
	objects.block17.shape = love.physics.newRectangleShape(0, 0, 200, 50)
	objects.block17.fixture = love.physics.newFixture(objects.block17.body, objects.block17.shape, 5)
	
	objects.block18 = {}
	objects.block18.body = love.physics.newBody(world, 250, 1300, "kinematic")
	objects.block18.shape = love.physics.newRectangleShape(0, 0, 300, 50)
	objects.block18.fixture = love.physics.newFixture(objects.block18.body, objects.block18.shape, 5)
	
	objects.block19 = {}
	objects.block19.body = love.physics.newBody(world, 400, 600, "dynamic")
	objects.block19.shape = love.physics.newRectangleShape(94, 150)
	objects.block19.fixture = love.physics.newFixture(objects.block19.body, objects.block19.shape, 1)
	objects.block19.body:setFixedRotation(true)
	
	objects.block20 = {}
	objects.block20.body = love.physics.newBody(world, 600, 600, "dynamic")
	objects.block20.shape = love.physics.newRectangleShape(94, 150)
	objects.block20.fixture = love.physics.newFixture(objects.block20.body, objects.block20.shape, 1)
	objects.block20.body:setFixedRotation(true)
	
	objects.block21 = {}
	objects.block21.body = love.physics.newBody(world, 800, 600, "dynamic")
	objects.block21.shape = love.physics.newRectangleShape(94, 150)
	objects.block21.fixture = love.physics.newFixture(objects.block21.body, objects.block21.shape, 1)
	objects.block21.body:setFixedRotation(true)
	
	Timer.addPeriodic(2.5, function() bup=true end)
	Timer.addPeriodic(1.5, function() bup2=true end)
	Timer.addPeriodic(2.9, function() bup3=true end)

	--initial graphics setup
	love.graphics.setBackgroundColor(104, 0, 248) --set the background color to a nice blue
	love.graphics.setMode(1024, 768, false, true, 0) --set the window dimensions to 1024 by 768
end

function game:update(dt)
	Timer.update(dt)
	
	moving = false
	walking = false

	cam:lookAt(objects.player.body:getX(), objects.player.body:getY())
	camx, camy = cam:pos()
	world:update(dt)
	
	change = yc-objects.player.body:getY()
	
	if bup==true then
		objects.block19.body:applyLinearImpulse(0, -2000)
		bup=false 
	end
	if bup2==true then
		objects.block20.body:applyLinearImpulse(0, -3000)
		bup2=false 
		else objects.block19.body:applyForce(0, -600)
		end
	if bup3==true then
		objects.block21.body:applyLinearImpulse(0, -4000)
		bup3=false 
	end
	
	if dead == false then
	if love.keyboard.isDown("right") then
		objects.player.body:applyForce(600, 0)
		right = true
		left = false
		anim:update(dt) 
		
		moving=true
		standing=false
		
		walking=true
		
		if air==true then 
			moving=false
			if jump==true then
				up = true
			else
				down = true
			end
		end
		
	end
		
	if love.keyboard.isDown("left") then 
		objects.player.body:applyForce(-600, 0)
		right = false
		left = true
		anim2:update(dt) 
		
		moving=true
		standing=false
		
		walking=true
		
		if air==true then 
			moving=false
			if jump==true then
				up = true
			else
				down = true
			end
		end
	end
		
	if love.keyboard.isDown("up") then 
		fx = 0
		fy = 0
		if yc==-9000 then 
		    yc = objects.player.body:getY() 
		end

		yc = objects.player.body:getY()
		
		fx, fy = objects.player.body:getLinearVelocity()
		
		if jump then
			if fy>=0 then if fy<.01 then
				jump = false
				up = false
				down = true
				objects.player.body:applyLinearImpulse(0, 10)
			end end
		end
		
		fx, fy = objects.player.body:getLinearVelocity()
		
		if jump==false then
			if fy>=0 then
				if fy<.0001 then
					if change == 0 then
						objects.player.body:applyLinearImpulse(0, -300) 
						jump = true
						
						up = true
						down = false
						air=true
					end
				end
			end
		end
		
		
		moving=true
		standing=false
		walking=false
	end
	end
	
	
	fx, fy = objects.player.body:getLinearVelocity()
	
	if moving==false then
		if air==false then
		if fx<500 then
			if fx>-500 then
				objects.player.body:setLinearVelocity(0, fy)
			end
		end
		end
	end
	
		
		if jump then
			if fy>=0 then if fy<.8 then
				jump = false
				up = false
				down = true
				objects.player.body:applyLinearImpulse(0, 10)
			end end
		end
		
	fx, fy = objects.player.body:getLinearVelocity()
		
		if jump==false then
			if fy>=0 then
				if fy<.8 then
						up = false
						down = false
						air=false
				end
			end
		end
	
	if fy>.1 then walking=false moving=false end
	
	if moving==false then 
		if walking==false then
			if air==false then
				if fy>.1 then
					standing=true
					down = true
				else
					if fx==0 then
						standing=true 
						down = false
					else
						walking=true
						moving=true
						standing=false
						if right==true then anim:update(dt)
						else anim2:update(dt) end
					end
				end
			end
		end
	end
	
	if dead == true then
		timeinit = love.timer.getTime()
		anim_dead:update(dt)
		if love.timer.getTime() - timeinit > 3 then
			objects.player.body:setPosition(200, 200)
			objects.player.body:setLinearVelocity(1,1)
			dead = false
		end
	end
	
	if checker then
			text = fx .. " " .. fy
		else
			text = " "
		end
	
	
	if first then
		standing = true
		right = true
		if fx ~= 0 then
			first=false
		end
	end
	
end

function game:draw()

	cam:attach()

	love.graphics.setColor(72, 160, 14)
	
	love.graphics.setColor(255,255,255)
	
	love.graphics.draw(bk, camx-512, camy-384)
	
	if dead==true then
		anim_dead:draw(objects.player.body:getX()-45, objects.player.body:getY()-40)
	end
	if right==true then 
		if up then
			love.graphics.draw(imageJumpingUp, objects.player.body:getX(), objects.player.body:getY(), objects.player.body:getAngle() , 1, 1, imageJumpingUp:getWidth()/2, imageJumpingUp:getHeight()/2+5) 
		end
		if walking then
			if up==false then 
				if down==false then
					anim:draw(objects.player.body:getX()-45, objects.player.body:getY()-40) 
				end
			end
		end
		if down then
					love.graphics.draw(imageJumpingDown, objects.player.body:getX(), objects.player.body:getY(), objects.player.body:getAngle() , 1, 1, imageJumpingDown:getWidth()/2, imageJumpingDown:getHeight()/2+5) 
		end
	end
	if left ==true then 
		if up then
			love.graphics.draw(imageJumpingUpLeft, objects.player.body:getX(), objects.player.body:getY(), objects.player.body:getAngle() , 1, 1, imageJumpingUpLeft:getWidth()/2, imageJumpingUpLeft:getHeight()/2+5) 
		end
		if walking then
			if up==false then 
				if down==false then
					anim2:draw(objects.player.body:getX()-45, objects.player.body:getY()-40) 
				end
			end
		end
		if down then
					love.graphics.draw(imageJumpingDownLeft, objects.player.body:getX(), objects.player.body:getY(), objects.player.body:getAngle() , 1, 1, imageJumpingDownLeft:getWidth()/2, imageJumpingDownLeft:getHeight()/2+5) 
		end
	end
	if standing==true then 	
		if right == true then
			if down == true then
				love.graphics.draw(imageJumpingDown, objects.player.body:getX(), objects.player.body:getY(), objects.player.body:getAngle() , 1, 1, imageJumpingDown:getWidth()/2, imageJumpingDown:getHeight()/2+5) 	
			else
				love.graphics.draw(imageStanding, objects.player.body:getX(), objects.player.body:getY(), objects.player.body:getAngle() , 1, 1, imageStanding:getWidth()/2, imageStanding:getHeight()/2+5) 
			end
		end
		if left == true then
			if down == true then
				love.graphics.draw(imageJumpingDownLeft, objects.player.body:getX(), objects.player.body:getY(), objects.player.body:getAngle() , 1, 1, imageJumpingDownLeft:getWidth()/2, imageJumpingDownLeft:getHeight()/2+5)
			else
				love.graphics.draw(imageStandingLeft, objects.player.body:getX(), objects.player.body:getY(), objects.player.body:getAngle() , 1, 1, imageStandingLeft:getWidth()/2, imageStandingLeft:getHeight()/2+5)
			end
		end
	end
	love.graphics.setColor(193, 47, 14)
	
	love.graphics.setColor(50, 50, 50) -- set the drawing color to grey for the blocks
	x1=0
	y1=0
	
	love.graphics.polygon("fill", objects.block1.body:getWorldPoints(objects.block1.shape:getPoints()))
	love.graphics.polygon("fill", objects.block2.body:getWorldPoints(objects.block2.shape:getPoints()))
	love.graphics.polygon("fill", objects.block3.body:getWorldPoints(objects.block3.shape:getPoints()))
	love.graphics.polygon("fill", objects.block4.body:getWorldPoints(objects.block4.shape:getPoints()))
	love.graphics.polygon("fill", objects.block5.body:getWorldPoints(objects.block5.shape:getPoints()))
	love.graphics.polygon("fill", objects.block6.body:getWorldPoints(objects.block6.shape:getPoints()))
	love.graphics.polygon("fill", objects.block7.body:getWorldPoints(objects.block7.shape:getPoints()))
	love.graphics.polygon("fill", objects.block8.body:getWorldPoints(objects.block8.shape:getPoints()))
	love.graphics.polygon("fill", objects.block9.body:getWorldPoints(objects.block9.shape:getPoints()))
	love.graphics.polygon("fill", objects.block10.body:getWorldPoints(objects.block10.shape:getPoints()))
	love.graphics.polygon("fill", objects.block11.body:getWorldPoints(objects.block11.shape:getPoints()))
	love.graphics.polygon("fill", objects.block12.body:getWorldPoints(objects.block12.shape:getPoints()))
	love.graphics.polygon("fill", objects.block13.body:getWorldPoints(objects.block13.shape:getPoints()))
	love.graphics.polygon("fill", objects.block14.body:getWorldPoints(objects.block14.shape:getPoints()))
	love.graphics.polygon("fill", objects.block15.body:getWorldPoints(objects.block15.shape:getPoints()))
	love.graphics.polygon("fill", objects.block16.body:getWorldPoints(objects.block16.shape:getPoints()))
	love.graphics.polygon("fill", objects.block17.body:getWorldPoints(objects.block17.shape:getPoints()))
	love.graphics.polygon("fill", objects.block18.body:getWorldPoints(objects.block18.shape:getPoints()))
	love.graphics.polygon("fill", objects.block19.body:getWorldPoints(objects.block19.shape:getPoints()))
	love.graphics.polygon("fill", objects.block20.body:getWorldPoints(objects.block20.shape:getPoints()))
	love.graphics.polygon("fill", objects.block21.body:getWorldPoints(objects.block21.shape:getPoints()))
	
	love.graphics.printf(text, 0, 0, 800)
	
	cam:detach()
end

function game:keypressed(key, u)
   --Debug
   if key == "f12" then --set to whatever key you want to use
      if(checker==true) then checker = false 
	  else checker = true end
   end
   if key == "escape" then
	  love.event.push("quit")
   end
   if key == "r" then
	  objects.player.body:setPosition(200, 200)
	  objects.player.body:setLinearVelocity(1,1)
   end
   if key == "d" then
	  right = false
	  left = false
	  standing = false
      dead = true
   end
end

