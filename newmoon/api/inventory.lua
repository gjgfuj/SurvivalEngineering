local inventory = newmoon.helper.optionaltable("inventory")
inventory.blank = {}
inventory.blank.inv = {}
---Modify this to change the maximum size of the inventory.
inventory.blank.size = 4
---Inserts an item into a certain slot of an inventory. Will override whatever's there. Defaults to the last untaken slot.
---Returns false if the slot is above the bounds, true otherwise.
function inventory.blank:insertItem(item, slot)
    if not slot then slot = #self.inv+1 end
    if slot > self.size then return false end
    self.inv[slot] = item
    return true
end
inventory.blank.setItem = inventory.blank.insertItem
---Gets an item from the inventory. Defaults to the last slot.
function inventory.blank:getItem(slot)
    if not slot then slot = #self.inv end
    local val = self.inv[slot]
    return val
end
---Gets an item from the inventory and removes that item from the inventory.
function inventory.blank:extractItem(slot)
    if not slot then slot = #self.inv end
    local val = self.inv[slot]
    self.inv[slot] = nil
    return val
end
---Installs the inventory api inside the component.
function inventory.install(component, size)
    local inv = newmoon.helper.copytable(inventory.blank)
    inv.size = size or 4
    component.__inventory = inv
end
---Retrieves the inventory api from the component.
function inventory.get(component)
    return component.__inventory
end
newmoon.api.inventory = inventory
return inventory