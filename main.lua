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
require("gui")
function love.load()
    w1 = world.new(100, 100)
    p1 = player:new()
    table.insert(w1.objects, p1)
    gui.create("frame")
end
function detectcollision(x,y)
    for _, object in pairs(w1.objects) do
        local ix = object.x-p1.x + love.window.getWidth() / 2
        local iy = object.y-p1.y + love.window.getHeight() / 2
        if ix < x and
                ix+object.sprite:getWidth() > x then
            if iy < y and iy+object.sprite:getHeight() > y then
                return object
            end
        end
    end
    local ix = 0-p1.x + love.window.getWidth() / 2
    local iy = 0-p1.y + love.window.getHeight() / 2
    if x < ix or x > ix+w1:getWidth() or y < iy or y > iy+w1:getHeight() then return "edge" end
    return nil
end
function love.mousepressed(x,y,btn)
    gui.buttonCheck(x,y,btn)
    local newobj = table.copy(objects.testObject)
    newobj.x = math.floor((p1.x-love.window.getWidth() / 2+x)/32)*32
    newobj.y = math.floor((p1.y-love.window.getHeight() / 2+y)/32)*32
    x = newobj.x - p1.x + love.window.getWidth() / 2
    y = newobj.y - p1.y + love.window.getHeight() / 2
    print("x:"..x.." y:"..y)
    local obj = detectcollision(x+2,y+2)
    if obj and obj ~= "edge" then obj.interact() return end
    local jig = detectcollision(x+newobj.sprite:getWidth()-2, y+2) or detectcollision(x+newobj.sprite:getWidth()-2, y+newobj.sprite:getHeight()-2) or detectcollision(x+2, y+newobj.sprite:getHeight()-2)
    if jig then
        print(jig)
        return
    end
    table.insert(w1.objects, newobj)
end

function love.update(delta)
    gui.update()
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
    gui.draw()
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
    --Hover Over
    local x = love.mouse.getX()
    local y = love.mouse.getY()
    local newobj = table.copy(objects.testObject)
    newobj.x = math.floor((p1.x-love.window.getWidth() / 2+x)/32)*32
    newobj.y = math.floor((p1.y-love.window.getHeight() / 2+y)/32)*32
    x = newobj.x - p1.x + love.window.getWidth() / 2
    y = newobj.y - p1.y + love.window.getHeight() / 2
    if not(detectcollision(x+2,y+2) or detectcollision(x+newobj.sprite:getWidth()-2, y+2) or detectcollision(x+newobj.sprite:getWidth()-2, y+newobj.sprite:getHeight()-2) or detectcollision(x+2, y+newobj.sprite:getHeight()-2)) then
        love.graphics.draw(newobj.sprite, newobj.x - p1.x + love.window.getWidth() / 2 - 32, newobj.y - p1.y + love.window.getHeight() / 2 - 32)
    end
    if debug then
        love.graphics.print("FPS: " .. tostring(love.timer.getFPS()), 10, 10)
    end
end