newmoon.mod.create("survivalengineering")
local grass = newmoon.tile.create("grass")
function grass.init:top()
    self.texture = newmoon.texture.new("tiles/grass")
end
function grass.init:voxel()
    self.texture = newmoon.texture.new("tiles/grass")
    self.material = newmoon.material.dirt
end
local chester = newmoon.object.create("chester")
function chester.init:top()
    self.sprite = newmoon.texture.new("sprites/bigchest")
    print("init:top()")
end
function chester.init:voxel()
    self.texture = newmoon.texture.new("objects/chester")
    print("init:voxel()")
end
function chester.callback:onUse()
    print("Interacted")
end