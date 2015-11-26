local player = {}
function player:new() return table.copy(self) end
function player:update() end
function player:interact() print("PLAYER INTERACT") end
player.x = 0
player.y = 0
player.speed = 300
player.sprite = love.graphics.newImage("assets/sprites/player.png")
return player