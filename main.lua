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

local debug = true
local world = require("world")
local w1
local player = require("player")
local p1
local objects = require("objects")
local o1
function love.load()
    w1 = world.new(100, 100)
    p1 = player:new()
    o1 = table.copy(objects.testObject)
    table.insert(w1.objects, o1)
    table.insert(w1.objects, p1)
end
function detectcollision(x,y)
    for _, object in pairs(w1.objects) do
        local ix = object.x-p1.x + love.window.getWidth() / 2
        local iy = object.y-p1.y + love.window.getHeight() / 2
        print("ix:"..ix.."x:"..x)
        if ix < x and
                ix+object.sprite:getWidth() > x then
            if iy < y and iy+object.sprite:getHeight() > y then
                return object
            end
        end
    end
    return nil
end
function love.mousepressed(x,y)
    local obj = detectcollision(x,y)
    if obj then obj.interact() return end
    local newobj = table.copy(objects.testObject)
    x = math.floor(x/32)*32
    y = math.floor(y/32)*32
    if detectcollision(x+newobj.sprite:getWidth(), y) or detectcollision(x+newobj.sprite:getWidth(), y+newobj.sprite:getHeight()) or detectcollision(x, y+newobj.sprite:getHeight()) then
        return
    end

    newobj.x = p1.x-love.window.getWidth() / 2+x
    newobj.y = p1.y - love.window.getHeight() / 2+y
    table.insert(w1.objects, newobj)
end

function love.update(delta)
    for _, object in pairs(w1.objects) do
            object:update(delta)
        end
    p1.lastx = p1.x
    p1.lasty = p1.y
    if love.keyboard.isDown('w') then
        p1.y = p1.y - delta * p1.speed
        if p1.y < 0 then
            p1.y = 0
        end

        for _, obj in ipairs(w1.objects) do
            if (p1.x > obj.x and p1.y > obj.y and p1.x < obj.x + obj.sprite:getWidth() and p1.y < obj.y + obj.sprite:getWidth()) then

                p1.y = p1.lasty
            end
            if (p1.x + p1.sprite:getWidth() > obj.x and p1.y > obj.y and p1.x + p1.sprite:getWidth() < obj.x + obj.sprite:getWidth() and p1.y < obj.y + obj.sprite:getWidth()) then

                p1.y = p1.lasty
            end
            if (p1.x > obj.x and p1.y + p1.sprite:getHeight() > obj.y and p1.x < obj.x + obj.sprite:getWidth() and p1.y + p1.sprite:getHeight() < obj.y + obj.sprite:getWidth()) then
                p1.y = p1.lasty
            end
            if (p1.x + p1.sprite:getWidth() > obj.x and p1.y + p1.sprite:getHeight() > obj.y and p1.x + p1.sprite:getWidth() < obj.x + obj.sprite:getWidth() and p1.y + p1.sprite:getHeight() < obj.y + obj.sprite:getWidth()) then

                p1.y = p1.lasty
            end
        end
    elseif love.keyboard.isDown('s') then
        p1.y = p1.y + delta * p1.speed
        if p1.y > w1:getHeight() - p1.sprite:getHeight() then p1.y = w1:getHeight() - p1.sprite:getHeight() end

        for _, obj in ipairs(w1.objects) do
            if (p1.x > obj.x and p1.y > obj.y and p1.x < obj.x + obj.sprite:getWidth() and p1.y < obj.y + obj.sprite:getWidth()) then

                p1.y = p1.lasty
            end
            if (p1.x + p1.sprite:getWidth() > obj.x and p1.y > obj.y and p1.x + p1.sprite:getWidth() < obj.x + obj.sprite:getWidth() and p1.y < obj.y + obj.sprite:getWidth()) then

                p1.y = p1.lasty
            end
            if (p1.x > obj.x and p1.y + p1.sprite:getHeight() > obj.y and p1.x < obj.x + obj.sprite:getWidth() and p1.y + p1.sprite:getHeight() < obj.y + obj.sprite:getWidth()) then

                p1.y = p1.lasty
            end
            if (p1.x + p1.sprite:getWidth() > obj.x and p1.y + p1.sprite:getHeight() > obj.y and p1.x + p1.sprite:getWidth() < obj.x + obj.sprite:getWidth() and p1.y + p1.sprite:getHeight() < obj.y + obj.sprite:getWidth()) then

                p1.y = p1.lasty
            end
        end
    end
    if love.keyboard.isDown('a') then
        p1.x = p1.x - delta * p1.speed
        if p1.x < 0 then
            p1.x = 0
        end
        for _, obj in ipairs(w1.objects) do
            if (p1.x > obj.x and p1.y > obj.y and p1.x < obj.x + obj.sprite:getWidth() and p1.y < obj.y + obj.sprite:getWidth()) then
                p1.x = p1.lastx
            end
            if (p1.x + p1.sprite:getWidth() > obj.x and p1.y > obj.y and p1.x + p1.sprite:getWidth() < obj.x + obj.sprite:getWidth() and p1.y < obj.y + obj.sprite:getWidth()) then
                p1.x = p1.lastx
            end
            if (p1.x > obj.x and p1.y + p1.sprite:getHeight() > obj.y and p1.x < obj.x + obj.sprite:getWidth() and p1.y + p1.sprite:getHeight() < obj.y + obj.sprite:getWidth()) then
                p1.x = p1.lastx
            end
            if (p1.x + p1.sprite:getWidth() > obj.x and p1.y + p1.sprite:getHeight() > obj.y and p1.x + p1.sprite:getWidth() < obj.x + obj.sprite:getWidth() and p1.y + p1.sprite:getHeight() < obj.y + obj.sprite:getWidth()) then
                p1.x = p1.lastx
            end
        end
    elseif love.keyboard.isDown('d') then
        p1.x = p1.x + delta * p1.speed
        if p1.x > w1:getWidth() - p1.sprite:getWidth() then p1.x = w1:getWidth() - p1.sprite:getWidth() end
        for _, obj in ipairs(w1.objects) do
            if (p1.x > obj.x and p1.y > obj.y and p1.x < obj.x + obj.sprite:getWidth() and p1.y < obj.y + obj.sprite:getWidth()) then
                p1.x = p1.lastx
            end
            if (p1.x + p1.sprite:getWidth() > obj.x and p1.y > obj.y and p1.x + p1.sprite:getWidth() < obj.x + obj.sprite:getWidth() and p1.y < obj.y + obj.sprite:getWidth()) then
                p1.x = p1.lastx
            end
            if (p1.x > obj.x and p1.y + p1.sprite:getHeight() > obj.y and p1.x < obj.x + obj.sprite:getWidth() and p1.y + p1.sprite:getHeight() < obj.y + obj.sprite:getWidth()) then
                p1.x = p1.lastx
            end
            if (p1.x + p1.sprite:getWidth() > obj.x and p1.y + p1.sprite:getHeight() > obj.y and p1.x + p1.sprite:getWidth() < obj.x + obj.sprite:getWidth() and p1.y + p1.sprite:getHeight() < obj.y + obj.sprite:getWidth()) then
                p1.x = p1.lastx
            end
        end
    end
end

function love.draw()
    for ix, tbl in ipairs(w1.tiles) do
        local posx = (ix - 1) * 32 - p1.x + love.window.getWidth() / 2 - 32
        if not (posx < -32 or posx > love.window.getWidth()) then
            for iy, tile in ipairs(tbl) do
                local posy = (iy - 1) * 32 - p1.y + love.window.getHeight() / 2 - 32
                if not (posy < -32 or posy > love.window.getHeight()) then
                    love.graphics.draw(tile, posx, posy)
                end
            end
        end
    end
    for i, obj in ipairs(w1.objects) do
        love.graphics.draw(obj.sprite, obj.x - p1.x + love.window.getWidth() / 2 - 32, obj.y - p1.y + love.window.getHeight() / 2 - 32)
    end
    --love.graphics.draw(p1.sprite, love.window.getWidth()/2-32, love.window.getHeight()/2-32)
    local x = love.mouse.getX()
    local y = love.mouse.getY()
    local newobj = table.copy(objects.testObject)
    x = math.floor(x/32)*32
    y = math.floor(y/32)*32
    if not(detectcollision(x,y) or detectcollision(x+newobj.sprite:getWidth(), y) or detectcollision(x+newobj.sprite:getWidth(), y+newobj.sprite:getHeight()) or detectcollision(x, y+newobj.sprite:getHeight())) then
        love.graphics.draw(newobj.sprite, x-32,y-32)
    end
    if debug then
        love.graphics.print("FPS: " .. tostring(love.timer.getFPS()), 10, 10)
    end
end