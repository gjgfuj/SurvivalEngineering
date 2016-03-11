newmoon.mod.create("SurvivalEngineeringContent")
local grass = newmoon.tile.create("grass")
function grass.init:top()
    self.texture = newmoon.texture.new("tiles/grass")
end
function grass.init:voxel()
    self.texture = newmoon.texture.new("tiles/grass")
end
local testchest = newmoon.object.create("testchest")
function testchest.init:top()
    self.sprite = newmoon.texture.new("sprites/bigchest")
    print("init:top()")
end
function testchest.callback:onUse()
    print("Interacted")
end