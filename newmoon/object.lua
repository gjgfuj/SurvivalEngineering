local object = {}
---Create a new object.
---Object id expected at object.id
---Init functions: voxel() (in a 3d voxel game), top() (in a top-down game), side() (in a side on platformer type game.)
---Callback functions: onUse() when the player activates the object.
function object.create(b) b.init={} b.callback={} return b end
newmoon.object = object
return object