local objects = {}
local testObject = {}
function testObject:update() end
function testObject:interact() print("INTERACTED") end
testObject.sprite = love.graphics.newImage("assets/sprites/bigchest.png")
testObject.x = 100
testObject.y = 100
objects.testObject = testObject
return objects