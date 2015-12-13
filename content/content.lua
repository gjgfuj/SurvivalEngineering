newmoon.mod.create("SurvivalEngineeringContent")
local testchest = newmoon.object.create({id="testchest"})
function testchest.init:top()
    self.sprite = newmoon.texture.newSprite("bigchest")
    print("init:top()")
end
function testchest.callback:onUse()
    print("Interacted")
end