-- mapFunctions.lua

function drawGroundLayer(gameMap, layerName)
    if gameMap.layers[layerName] then
        gameMap:drawLayer(gameMap.layers[layerName])
    end
end

local m = {}

m.drawGroundLayer = drawGroundLayer

return m

