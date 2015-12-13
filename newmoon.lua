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
---Mod stuff.
newmoon.mod = {}
newmoon.mod.mods = {}
---Create a new mod. Will register it to whatever registry is required.
function newmoon.mod.create(id)
    table.insert(newmoon.mod.mods, id)
    newmoon.mod.currentmod = id
    return {id=id}
end
newmoon.object = require("newmoon/object")
newmoon.item = require("newmoon/item")
newmoon.texture = {}
newmoon.api = {}
newmoon.api.inventory = require("newmoon/api/inventory")
---Implementation methods.
function newmoon.texture.newSprite() print("newmoon.texture.newSprite not implemented") end
return newmoon