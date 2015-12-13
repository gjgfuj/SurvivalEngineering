local newmoon = require("newmoon")
local objects = require("objects")
local oldObjectCreate = newmoon.object.create
function newmoon.object.create(b,...)
    local obj = oldObjectCreate(b,...)
    objects[b.id] = {newmoon=obj,interact=function() obj.callback.onUse() end,update=function() obj.callback.tick() end }
    return obj
end
function newmoon.texture.newSprite(name)
    return love.graphics.newImage("assets/sprites/"..name..".png")
end
function newmoon.loadMods()
    require("content.content")
end
function newmoon.finalizeLoading()
    for _,obj in pairs(objects) do
        if obj.newmoon then
            obj.newmoon.init.top(obj.newmoon)
            obj.sprite = obj.newmoon.sprite
        end
    end
end
return newmoon