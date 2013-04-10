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
	--[[ 
	objects.pig.shapes = {
			love.physics.newPolygonShape(  12.00, -40.50  ,  15.00, -30.50  ,  9.00, -32.50  ,  9.00, -38.50  ,  10.00, -40.50 ),
			love.physics.newPolygonShape(  -32.00, -11.50  ,  -20.00, -16.50  ,  -30.00, -7.50  ,  -32.00, -8.50 ),
			love.physics.newPolygonShape(  21.00, -14.50  ,  6.00, -21.50  ,  22.00, -28.50  ,  24.00, -20.50  ,  24.00, -16.50 ),
			love.physics.newPolygonShape(  -25.00, -23.50  ,  -20.00, -16.50  ,  -32.00, -11.50  ,  -35.00, -13.50  ,  -35.00, -18.50  ,  -31.00, -23.50 ),
			love.physics.newPolygonShape(  29.00, -6.50  ,  21.00, -14.50  ,  29.00, -11.50 ),
			love.physics.newPolygonShape(  -11.00, -34.50  ,  -5.00, -34.50  ,  -2.00, -31.50  ,  -2.00, -21.50  ,  -13.00, -19.50  ,  -16.00, -22.50  ,  -16.00, -31.50 ),
			love.physics.newPolygonShape(  15.00, -30.50  ,  8.00, -27.50  ,  9.00, -32.50 ),
			love.physics.newPolygonShape(  24.00, -20.50  ,  22.00, -28.50  ,  27.00, -24.50  ,  27.00, -22.50 ),
			love.physics.newPolygonShape(  8.00, -27.50  ,  15.00, -30.50  ,  22.00, -28.50  ,  6.00, -21.50  ,  6.00, -25.50 ),
			love.physics.newPolygonShape(  22.00, -28.50  ,  15.00, -30.50  ,  20.00, -35.50  ,  22.00, -35.50 ),
			love.physics.newPolygonShape(  -13.00, -19.50  ,  29.00, -6.50  ,  32.00, -4.50  ,  -36.00, 24.50  ,  -20.00, -16.50  ,  -16.00, -19.50 ),
			love.physics.newPolygonShape(  -36.00, 24.50  ,  32.00, -4.50  ,  22.00, 37.50  ,  11.00, 40.50  ,  -11.00, 40.50  ,  -28.00, 34.50 ),
			love.physics.newPolygonShape(  27.00, -24.50  ,  22.00, -28.50  ,  33.00, -30.50  ,  33.00, -28.50 ),
			love.physics.newPolygonShape(  -30.00, -7.50  ,  -20.00, -16.50  ,  -36.00, 24.50  ,  -38.00, 16.50  ,  -38.00, 5.50  ,  -35.00, -2.50 ),
			love.physics.newPolygonShape(  29.00, 33.50  ,  22.00, 37.50  ,  32.00, -4.50  ,  37.00, 4.50  ,  38.00, 17.50  ,  35.00, 26.50 ),
			love.physics.newPolygonShape(  29.00, -6.50  ,  -13.00, -19.50  ,  -2.00, -21.50  ,  6.00, -21.50  ,  21.00, -14.50 )
		}
	objects.pig.fixtures ={}
	for i=1, #objects.pig.shapes do
      objects.pig.fixtures[i] = love.physics.newFixture(objects.pig.body, objects.pig.shapes[i],2)
    end
	--]]
	
	objects.pig.shape = love.physics.newRectangleShape(76, 81) --make a rectangle with a width of 1024 and a height of 50
	objects.pig.fixture = love.physics.newFixture(objects.pig.body, objects.pig.shape); --attach shape to body

	
	objects.pig.body:setFixedRotation(true)
	
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
	
	objects.block4 = {}
	objects.block4.body = love.physics.newBody(world, 1, 300, "kinematic")
	objects.block4.shape = love.physics.newRectangleShape(0, 0, 500, 100)
	objects.block4.fixture = love.physics.newFixture(objects.block4.body, objects.block4.shape, 5)
	
	objects.block5 = {}
	objects.block5.body = love.physics.newBody(world, 0,0, "kinematic")
	objects.block5.shape = love.physics.newRectangleShape(0, 0, 1000, 100)
	objects.block5.fixture = love.physics.newFixture(objects.block5.body, objects.block5.shape, 5)

	--initial graphics setup
	love.graphics.setBackgroundColor(104, 0, 248) --set the background color to a nice blue
	love.graphics.setMode(1024, 768, false, true, 0) --set the window dimensions to 1024 by 768
end

yc = -9000
change = 0

function love.update(dt)
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
		
		if checker then
			text = objects.pig.body:getX() .. " " .. objects.pig.body:getY()
		else
			text = " "
		end
	end
end

function love.draw()
	love.graphics.setColor(72, 160, 14) -- set the drawing color to green for the ground
	love.graphics.polygon("fill", objects.ground.body:getWorldPoints(objects.ground.shape:getPoints())) -- draw a "filled in" polygon using the ground's coordinates

	love.graphics.setColor(255,255,255)
	love.graphics.draw(imagePig, objects.pig.body:getX(), objects.pig.body:getY(), objects.pig.body:getAngle() , 1, 1, imagePig:getWidth()/2, imagePig:getHeight()/2)
	
	love.graphics.setColor(193, 47, 14)
	
	love.graphics.setColor(50, 50, 50) -- set the drawing color to grey for the blocks
	love.graphics.polygon("fill", objects.block1.body:getWorldPoints(objects.block1.shape:getPoints()))
	love.graphics.polygon("fill", objects.block2.body:getWorldPoints(objects.block2.shape:getPoints()))
	love.graphics.polygon("fill", objects.block3.body:getWorldPoints(objects.block3.shape:getPoints()))
	love.graphics.polygon("fill", objects.block4.body:getWorldPoints(objects.block4.shape:getPoints()))
	love.graphics.polygon("fill", objects.block5.body:getWorldPoints(objects.block5.shape:getPoints()))
	
	love.graphics.printf(text, 0, 0, 800)
end

function love.keypressed(key, u)
   --Debug
   if key == "f12" then --set to whatever key you want to use
      if(checker==true) then checker = false 
	  else checker = true end
   end
end
