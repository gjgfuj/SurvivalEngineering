local newmoon = require("newmoon")
local objects = require("objects")
local oldObjectCreate = newmoon.object.create
function newmoon.object.create(b,...)
    local obj = oldObjectCreate(b,...)
    objects[b.id] = {newmoon=obj}
    return obj
end
function newmoon.texture.new(name)
    return love.graphics.newImage(love.path.join("assets","sprites",name))
end
function newmoon.load()
    for obj in pairs(objects) do
        if obj.newmoon then
            obj.newmoon.init.top(obj.newmoon)
        end
    end
end
return newmoon