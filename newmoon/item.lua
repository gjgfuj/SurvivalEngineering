local item = {}
---Create a new item.
---Init functions: voxel() (in a 3d voxel game), top() (in a top-down game), side() (in a side on platformer type game.)
---Callback functions: onUse() when the player activates the item.
function item.create(b) b.init={} b.callback={} return b end
newmoon.item = item
return item