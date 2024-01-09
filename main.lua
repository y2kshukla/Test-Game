function love.load()
    initializePhysics()
    initializeCamera()

    anim8 = require 'libs.anim8.anim8'
    love.graphics.setDefaultFilter("nearest", "nearest")

    sti = require 'libs.Simple-Tiled-Implementation.sti'

    player = require 'components.player'
    player.initialize(world)

    gameMap = require 'components.gamemaps'
    gameMap.loadMap('maps/stage2/test2.lua')
end

function love.update(dt)
    -- checkInteractions()
    world:update(dt)

    player = require 'components.player'
    player.update(dt)

    cam:lookAt(player.x, player.y)

    local w = love.graphics.getWidth()
    local h = love.graphics.getHeight()

    if cam.x < w/2 then 
        cam.x = w/2
    end
    if cam.y < h/2 then
        cam.y = h/2
    end

    local tileWidth = gameMap.tilewidth
    local tileHeight = gameMap.tileheight
    local mapW = gameMap.width * tileWidth
    local mapH = gameMap.height * tileHeight

    --Right border
    if cam.x > (mapW - w/2) then
        cam.x = (mapW - w/2)
    end

    -- Bottom border
    if cam.y > (mapH - h/2) then
        cam.y = (mapH - h/2)
    end

end

function love.draw()
    cam:attach()
        gameMaps = require 'components.gamemaps'
        gameMaps.drawMap()

        player = require 'components.player'
        player.draw()

        -- world:draw()
    cam:detach()
end

-- function checkInteractions()
--     print("Hello, World!")
--     local playerX, playerY = player.collider:getPosition()

--     -- Iterate through objects in the "changeWorld" layer
--     if gameMap.layers["changeWorld"] then
--         for _, obj in pairs(gameMap.layers["changeWorld"].objects) do
--             -- Check if the player is close to an object in the "changeWorld" layer
--             local distance = math.sqrt((playerX - obj.x)^2 + (playerY - obj.y)^2)
--             if distance < 50 then -- Adjust the distance threshold as needed
--                 gameMap = sti('maps/testTiles.lua')
--                 -- print('hellow')
--             end
--         end
--     end
-- end

-- Utility functions
function initializePhysics()
    wf = require 'libs.windfield.windfield'
    world = wf.newWorld(0, 0)
end

function initializeCamera()
    camera = require 'libs.hump.camera'
    cam = camera()
end
