local tiles = require("tiles")

local world = {}
world.baseWorld = {}
local bw = world.baseWorld

bw.tiles = {}
bw.objects = {}
function bw:setTile(x,y,tile)
    if self.tiles[x] == nil then self.tiles[x] = {} end
    self.tiles[x][y] = tile
end
function bw:getWidth()
    return (#self.tiles)*tiles.grass:getWidth()
end
function bw:getHeight()
    return (#(self.tiles[1]))*tiles.grass:getHeight()
end
function bw:tick()
    for _, object in pairs(self.objects) do
        object:tick()
    end
end
function world.new(x,y)
    local w = table.copy(world.baseWorld)
    for ix = 1,x do
        for iy = 1,y do
            w:setTile(ix,iy,tiles.grass)
        end
    end
    return w
end
return world