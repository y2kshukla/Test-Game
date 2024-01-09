local gamemaps = {}

function gamemaps.loadMap(mapName)
    gameMap = sti(mapName)

    walls = {}
    if gameMap.layers['walls'] then
        for i, obj in pairs(gameMap.layers['walls'].objects) do
            local wall = world:newRectangleCollider(obj.x, obj.y, obj.width, obj.height)
            wall:setType('static')
            table.insert(walls, wall)
        end
    end
end

function gamemaps.drawMap()
    local m = require "utils.checkLayer"
    m.drawGroundLayer(gameMap, 'ground')
    m.drawGroundLayer(gameMap, 'changeWorld')
    m.drawGroundLayer(gameMap, 'trees')
end

return gamemaps