local player = {}
function player:new() return table.copy(self) end
player.x = 0
player.y = 0
player.speed = 100
player.sprite = love.graphics.newImage("assets/sprites/player.png")
return player