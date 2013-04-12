Camera = require "camera"

function love.load()
	text = " "
	love.physics.setMeter(100) --the height of a meter our worlds will be 64px
	world = love.physics.newWorld(0, 9.81*64, true) --create a world for the bodies to exist in with horizontal gravity of 0 and vertical gravity of 9.81
	
	world:setCallbacks(beginContact, endContact, preSolve, postSolve)

	objects = {} -- table to hold all our physical objects

	--let's create the ground
	objects.ground = {}
	objects.ground.body = love.physics.newBody(world, 1024/2, 768-50/2) --remember, the shape (the rectangle we create next) anchors to the body from its center, so we have to move it to (1024/2, 768-50/2)
	objects.ground.shape = love.physics.newRectangleShape(1024, 50) --make a rectangle with a width of 1024 and a height of 50
	objects.ground.fixture = love.physics.newFixture(objects.ground.body, objects.ground.shape); --attach shape to body

	imagePig = love.graphics.newImage("queen_pig.png")
	objects.pig = {}
	objects.pig.body = love.physics.newBody(world, 1024/2, 768-100, "dynamic")
	objects.pig.image = imagePig
	objects.pig.shape = love.physics.newRectangleShape(76, 81) --make a rectangle with a width of 1024 and a height of 50
	objects.pig.fixture = love.physics.newFixture(objects.pig.body, objects.pig.shape); --attach shape to body
	objects.pig.body:setFixedRotation(true)
	
	cam = Camera(objects.pig.body:getX(), objects.pig.body:getY())
	
	objects.block1 = {}
	objects.block1.body = love.physics.newBody(world, 400, 568, "kinematic")
	objects.block1.shape = love.physics.newRectangleShape(0, 0, 100, 100)
	objects.block1.fixture = love.physics.newFixture(objects.block1.body, objects.block1.shape, 5) -- A higher density gives it more mass.

	objects.block2 = {}
	objects.block2.body = love.physics.newBody(world, 200, 618, "kinematic")
	objects.block2.shape = love.physics.newRectangleShape(0, 0, 100, 50)
	objects.block2.fixture = love.physics.newFixture(objects.block2.body, objects.block2.shape, 2)
	
	objects.block3 = {}
	objects.block3.body = love.physics.newBody(world, 600, 468, "kinematic")
	objects.block3.shape = love.physics.newRectangleShape(0, 0, 400, 100)
	objects.block3.fixture = love.physics.newFixture(objects.block3.body, objects.block3.shape, 5) -- A higher density gives it more mass.
	

	--initial graphics setup
	love.graphics.setBackgroundColor(104, 0, 248) --set the background color to a nice blue
	love.graphics.setMode(1024, 768, false, true, 0) --set the window dimensions to 1024 by 768
end

yc = -9000
change = 0

function love.update(dt)
	cam:lookAt(objects.pig.body:getX(), objects.pig.body:getY())
	world:update(dt)
	
	change = yc-objects.pig.body:getY()
	
	if love.keyboard.isDown("right") then --press the right arrow key to push the ball to the right
		objects.pig.body:applyForce(1000, 0)
		end
		
	if love.keyboard.isDown("left") then --press the left arrow key to push the ball to the left
		objects.pig.body:applyForce(-1000, 0)
		end
		
	if love.keyboard.isDown("up") then --press the up arrow key to set the ball in the air
		fx = 0
		fy = 0
		if yc==-9000 then 
		    yc = objects.pig.body:getY() 
		end

		yc = objects.pig.body:getY()
		
		fx, fy = objects.pig.body:getLinearVelocity()
		
		fyn = tonumber(fy)
		
		if fy>=0 then
			if fy<.0001 then
				if change == 0 then
					--objects.pig.body:applyForce(0, -1000)
					objects.pig.body:applyLinearImpulse(0, -300) 
				end
			end
		end
	end
	if checker then
			text = objects.pig.body:getX() .. " " .. objects.pig.body:getY()
		else
			text = " "
	end
end

function love.draw()
	cam:attach()
	love.graphics.setColor(72, 160, 14) -- set the drawing color to green for the ground
	love.graphics.polygon("fill", objects.ground.body:getWorldPoints(objects.ground.shape:getPoints())) -- draw a "filled in" polygon using the ground's coordinates

	love.graphics.setColor(255,255,255)
	love.graphics.draw(imagePig, objects.pig.body:getX(), objects.pig.body:getY(), objects.pig.body:getAngle() , 1, 1, imagePig:getWidth()/2, imagePig:getHeight()/2)
	
	love.graphics.setColor(193, 47, 14)
	
	love.graphics.setColor(50, 50, 50) -- set the drawing color to grey for the blocks
	love.graphics.polygon("fill", objects.block1.body:getWorldPoints(objects.block1.shape:getPoints()))
	love.graphics.polygon("fill", objects.block2.body:getWorldPoints(objects.block2.shape:getPoints()))
	love.graphics.polygon("fill", objects.block3.body:getWorldPoints(objects.block3.shape:getPoints()))
	
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
end
