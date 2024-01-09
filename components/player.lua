-- player.lua

function updatePlayerMovement(dt)
    local isMoving = false
    local vx, vy = 0, 0

    if love.keyboard.isDown("right") then
        vx = player.speed
        player.anim = player.animations.right
        isMoving = true
    end
    if love.keyboard.isDown("left") then
        vx = -player.speed
        player.anim = player.animations.left
        isMoving = true
    end
    if love.keyboard.isDown("down") then
        vy = player.speed
        player.anim = player.animations.down
        isMoving = true
    end
    if love.keyboard.isDown("up") then
        vy = -player.speed
        player.anim = player.animations.up
        isMoving = true
    end

    player.collider:setLinearVelocity(vx, vy)

    if love.keyboard.isDown("lshift") or love.keyboard.isDown("rshift") then
        player.speed = 800
    else
        player.speed = 300
    end

    if not isMoving then
        player.anim:gotoFrame(2)
    end
end


local player = {}

function player.initialize(world)
    player.collider = world:newBSGRectangleCollider(400, 250, 50, 40, 10)
    player.collider:setFixedRotation(true)
    player.x = 400
    player.y = 200
    player.radius = 100
    player.speed = 300
    player.spriteSheet = love.graphics.newImage('assets/images/player-sheet.png')
    player.grid = anim8.newGrid(12, 18, player.spriteSheet:getWidth(), player.spriteSheet:getHeight())
    player.animations = {
        down = anim8.newAnimation(player.grid('1-4', 1), 0.2),
        left = anim8.newAnimation(player.grid('1-4', 2), 0.2),
        right = anim8.newAnimation(player.grid('1-4', 3), 0.2),
        up = anim8.newAnimation(player.grid('1-4', 4), 0.2)
    }
    player.anim = player.animations.down

    return player
end

function player.update(dt)
    updatePlayerMovement(dt)
    
    player.x = player.collider:getX()
    player.y = player.collider:getY()

    player.anim:update(dt)
    -- Add player update logic here
end

function player.draw()
    player.anim:draw(player.spriteSheet, player.x, player.y, nil, 6, nil, 6, 12)
end

return player