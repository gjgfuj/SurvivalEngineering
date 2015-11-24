function table.copy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[table.copy(orig_key)] = table.copy(orig_value)
        end
        setmetatable(copy, table.copy(getmetatable(orig)))
    else -- number, string, boolean, etc
    copy = orig
    end
    return copy
end
local world = require("world")
local w1
local player = require("player")
local p1
function love.load()
    w1 = world.new(100,100)
    p1 = player:new()
end
function love.update(delta)
    if love.keyboard.isDown('w') then
        p1.y = p1.y - delta*p1.speed
        if p1.y < 0 then
            p1.y = 0
        end
    elseif love.keyboard.isDown('s') then
        p1.y = p1.y + delta*p1.speed
        if p1.y > w1:getHeight()-p1.sprite:getHeight() then p1.y = w1:getHeight()-p1.sprite:getHeight() end
    end
    if love.keyboard.isDown('a') then
        p1.x = p1.x - delta*p1.speed
        if p1.x < 0 then
            p1.x = 0
        end
    elseif love.keyboard.isDown('d') then
        p1.x = p1.x + delta*p1.speed
        if p1.x > w1:getWidth()-p1.sprite:getWidth() then p1.x = w1:getWidth()-p1.sprite:getWidth() end
    end
end
function love.draw()
    for ix,tbl in ipairs(w1.tiles) do
        for iy,tile in ipairs(tbl) do
            local posx = (ix-1)*32-p1.x+love.window.getWidth()/2-32
            local posy = (iy-1)*32-p1.y+love.window.getHeight()/2-32
            if not ((posx < -32 or posx > love.window.getWidth()) and (posy < -32 or posy > love.window.getHeight())) then
                love.graphics.draw(tile, posx, posy)
            end
        end
    end
    love.graphics.draw(p1.sprite, love.window.getWidth()/2-32, love.window.getHeight()/2-32)
end