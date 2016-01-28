_G.newmoon = {}
---Helper functions for general lua stuff.
newmoon.helper = {}
function newmoon.helper.copytable(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[newmoon.helper.copytable(orig_key)] = newmoon.helper.copytable(orig_value)
        end
        setmetatable(copy, newmoon.helper.copytable(getmetatable(orig)))
    else -- number, string, boolean, etc
    copy = orig
    end
    return copy
end
newmoon.helper.optionaltablemeta = {}
function newmoon.helper.optionaltablemeta.__index(t,k)
    print(t.."."..k.." not implemented")
end
function newmoon.helper.optionaltable(name)
    return setmetatable({__apiname=name}, newmoon.helper.optionaltablemeta)
end
local tnew = newmoon.helper.optionaltable
---Mod stuff.
newmoon.mod = {}
newmoon.mod.mods = {}
---Create a new mod. Will register it to whatever registry is required.
function newmoon.mod.create(id)
    local mod = {id=id,objects=tnew(),item=tnew()}
    newmoon.mod.mods[id] = mod
    newmoon.mod.currentmod = mod
    return mod
end
newmoon.object = require("newmoon/object")
newmoon.item = require("newmoon/item")
newmoon.texture = tnew("texture")
newmoon.api = tnew("api")
newmoon.api.inventory = require("newmoon/api/inventory")
return newmoon