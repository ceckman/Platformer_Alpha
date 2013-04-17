require "AnAL"
Camera = require "camera"

function love.load()

	local img  = love.graphics.newImage("running.png")
	local img2  = love.graphics.newImage("runningbetterleft.png")
   --image, frame width, frame height, fps
   anim = newAnimation(img, 93, 75, .2, 0)
   --choose either loop, bounce, or once for setMode
   anim:setMode("loop")
   
   imageStanding = love.graphics.newImage("standingbetter.png")
   imageStandingLeft = love.graphics.newImage("standingleft.png")
   
   
   anim2 = newAnimation(img2, 93, 75, .2, 0)
<<<<<<< HEAD:main.lua
   anim2:setMode("loop")

=======
   --choose either loop, bounce, or once for setMode
   anim2:setMode("loop")


>>>>>>> v.84:Platformer/main.lua
	text = " "
	love.physics.setMeter(100) --the height of a meter our worlds will be 64px
	world = love.physics.newWorld(0, 9.81*64, true) --create a world for the bodies to exist in with horizontal gravity of 0 and vertical gravity of 9.81
	
	world:setCallbacks(beginContact, endContact, preSolve, postSolve)

	
	objects = {} -- table to hold all our physical objects

<<<<<<< HEAD:main.lua
	objects.player = {}
	objects.player.body = love.physics.newBody(world, 80, 65, "dynamic")
	objects.player.shape = love.physics.newRectangleShape(80, 65) --make a rectangle with a width of 1024 and a height of 50
	objects.player.fixture = love.physics.newFixture(objects.player.body, objects.player.shape); --attach shape to body
	objects.player.body:setFixedRotation(true)
=======
	--imagePig = love.graphics.newImage("queen_pig.png")
	objects.pig = {}
	objects.pig.body = love.physics.newBody(world, 80, 65, "dynamic")
	--objects.pig.image = imagePig
	objects.pig.shape = love.physics.newRectangleShape(80, 65) --make a rectangle with a width of 1024 and a height of 50
	objects.pig.fixture = love.physics.newFixture(objects.pig.body, objects.pig.shape); --attach shape to body
	objects.pig.body:setFixedRotation(true)
>>>>>>> v.84:Platformer/main.lua
	
	cam = Camera(objects.player.body:getX(), objects.player.body:getY())
	
	objects.block1 = {}
	objects.block1.body = love.physics.newBody(world, 0, 350, "kinematic")
	objects.block1.shape = love.physics.newRectangleShape(0, 0, 400, 100)
	objects.block1.fixture = love.physics.newFixture(objects.block1.body, objects.block1.shape, 5) -- A higher density gives it more mass.

	objects.block2 = {}
	objects.block2.body = love.physics.newBody(world, 600, 300, "kinematic")
	objects.block2.shape = love.physics.newRectangleShape(0, 0, 200, 200)
	objects.block2.fixture = love.physics.newFixture(objects.block2.body, objects.block2.shape, 2)
	
	objects.block3 = {}
	objects.block3.body = love.physics.newBody(world, 500, 468, "kinematic")
	objects.block3.shape = love.physics.newRectangleShape(0, 0, 100, 200)
	objects.block3.fixture = love.physics.newFixture(objects.block3.body, objects.block3.shape, 5) -- A higher density gives it more mass.
	
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
	objects.block8.body = love.physics.newBody(world, 1200, 1000, "kinematic")
	objects.block8.shape = love.physics.newRectangleShape(0, 0, 200, 1200)
	objects.block8.fixture = love.physics.newFixture(objects.block8.body, objects.block8.shape, 2)

	--initial graphics setup
	love.graphics.setBackgroundColor(104, 0, 248) --set the background color to a nice blue
	love.graphics.setMode(1024, 768, false, true, 0) --set the window dimensions to 1024 by 768
end

yc = -9000
change = 0
jump = false
jumping = false
didit = true
left = false
right = false
standing = true
air = false
up = false
mid = false
down = false
walking= false

function love.update(dt)

	moving = false
	walking = false

<<<<<<< HEAD:main.lua
	cam:lookAt(objects.player.body:getX(), objects.player.body:getY())
	world:update(dt)
	
	change = yc-objects.player.body:getY()
	
	if love.keyboard.isDown("right") then
		objects.player.body:applyForce(1000, 0)
=======
	cam:lookAt(objects.pig.body:getX(), objects.pig.body:getY())
	world:update(dt)
	
	change = yc-objects.pig.body:getY()
	
	if love.keyboard.isDown("right") then
		objects.pig.body:applyForce(1000, 0)
>>>>>>> v.84:Platformer/main.lua
		right = true
		left = false
		anim:update(dt) 
		
		moving=true
		standing=false
		
		if air==true then 
			moving=false
			if jump==true then
				up = true
			else
				down = true
			end
		end
		walking=true
	end
<<<<<<< HEAD:main.lua
		
	if love.keyboard.isDown("left") then 
		objects.player.body:applyForce(-1000, 0)
		right = false
		left = true
		anim2:update(dt) 
		
=======
		
	if love.keyboard.isDown("left") then 
		objects.pig.body:applyForce(-1000, 0)
		right = false
		left = true
		anim2:update(dt) 
		
>>>>>>> v.84:Platformer/main.lua
		moving=true
		standing=false
		
		if air==true then 
			moving=false
			if jump==true then
				up = true
			else
				down = true
			end
		end
		walking=true
	end
		
	if love.keyboard.isDown("up") then 
		fx = 0
		fy = 0
		if yc==-9000 then 
<<<<<<< HEAD:main.lua
		    yc = objects.player.body:getY() 
=======
		    yc = objects.pig.body:getY() 
			
		
>>>>>>> v.84:Platformer/main.lua
		end

		yc = objects.player.body:getY()
		
		fx, fy = objects.player.body:getLinearVelocity()
		
		if jump then
			if fy>=0 then if fy<.0001 then
				didit = true
				jump = false
				up = false
				down = true
<<<<<<< HEAD:main.lua
				objects.player.body:applyLinearImpulse(0, 10)
			end
=======
				objects.pig.body:applyLinearImpulse(0, 10)
			end end
>>>>>>> v.84:Platformer/main.lua
		end
	end
		
		fx, fy = objects.player.body:getLinearVelocity()
		
		if jump==false then
			if fy>=0 then
				if fy<.0001 then
					if change == 0 then
						objects.player.body:applyLinearImpulse(0, -300) 
						didit = false
						jump = true
						
						up = true
						down = false
						air=true
					end
				end
			end
		end
		
		if checker then
			text = objects.player.body:getX() .. " " .. objects.player.body:getY() .. " " .. tostring(jump) .. " " .. tostring(didit)
		else
			text = " "
		end
		moving=true
		standing=false
		walking=false
<<<<<<< HEAD:main.lua
	end
	
	if moving==false then 
		if walking==false then
		standing=true 
		end
	end
	
	
	fx, fy = objects.player.body:getLinearVelocity()
=======
	end
	
	if moving==false then 
		if walking==false then
		standing=true 
		end
	end
	
	
	fx, fy = objects.pig.body:getLinearVelocity()
>>>>>>> v.84:Platformer/main.lua
		if fy>=0 then
			if fy<.0001 then
				if jump==false then
					air=false
				end
			end
		end
	
end

function love.draw()

	
<<<<<<< HEAD:main.lua
=======

	cam:attach()

>>>>>>> v.84:Platformer/main.lua
	love.graphics.setColor(72, 160, 14) -- set the drawing color to green for the ground
	love.graphics.setColor(255,255,255)
<<<<<<< HEAD:main.lua
	
	if right==true then 
		if walking then
			anim:draw(objects.player.body:getX()-45, objects.player.body:getY()-40) 
=======
	--love.graphics.draw(imagePig, objects.pig.body:getX(), objects.pig.body:getY(), objects.pig.body:getAngle() , 1, 1, imagePig:getWidth()/2, imagePig:getHeight()/2)
	
	
	if right==true then 
		if walking then
			anim:draw(objects.pig.body:getX()-45, objects.pig.body:getY()-40) 
>>>>>>> v.84:Platformer/main.lua
		end
	end
	if left ==true then 
		if walking then
<<<<<<< HEAD:main.lua
			anim2:draw(objects.player.body:getX()-45, objects.player.body:getY()-40) 
=======
			anim2:draw(objects.pig.body:getX()-45, objects.pig.body:getY()-40) 
>>>>>>> v.84:Platformer/main.lua
		end
	end
	if standing==true then 	
		if right == true then
<<<<<<< HEAD:main.lua
			love.graphics.draw(imageStanding, objects.player.body:getX(), objects.player.body:getY(), objects.player.body:getAngle() , 1, 1, imageStanding:getWidth()/2, imageStanding:getHeight()/2+5) 
		end
		if left == true then
			love.graphics.draw(imageStandingLeft, objects.player.body:getX(), objects.player.body:getY(), objects.player.body:getAngle() , 1, 1, imageStandingLeft:getWidth()/2, imageStandingLeft:getHeight()/2+5)
=======
			love.graphics.draw(imageStanding, objects.pig.body:getX(), objects.pig.body:getY(), objects.pig.body:getAngle() , 1, 1, imageStanding:getWidth()/2, imageStanding:getHeight()/2+5) 
		end
		if left == true then
			love.graphics.draw(imageStandingLeft, objects.pig.body:getX(), objects.pig.body:getY(), objects.pig.body:getAngle() , 1, 1, imageStandingLeft:getWidth()/2, imageStandingLeft:getHeight()/2+5)
>>>>>>> v.84:Platformer/main.lua
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
	
	love.graphics.printf(text, 0, 0, 800)
	
	cam:detach()
end

function love.keypressed(key, u)
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
	  objects.player.body:setLinearVelocity(0,0)
   end
end
<<<<<<< HEAD:main.lua
=======









































>>>>>>> v.84:Platformer/main.lua
