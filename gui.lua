

local lg = love.graphics
local lm = love.mouse

function table.copyLight(orig)
    local new = {}
    for k,v in pairs(orig) do
        new[k] = v
    end
    return new
end
gui = {}
gui.objects = {} -- Objects that have been created.
gui.panels = {} -- Panels that have been registered.
gui.cache = {}
gui._maxz = 0
gui._minz = 0
gui.pos = 0
function uerror(_, ...) error(...) end

--[[----------------------------------------
	gui.create( base, parent )
	Used to create GUI panels.
--]]----------------------------------------
function gui.create( base, parent )
	local panel = {}
	local bPanel = gui.panels[ base ]
	if bPanel then 
		panel = table.copy( bPanel )
	else 
		uerror( ERROR_GUI, "Invalid panel class specified." )
		return
	end
	
	if parent then
		panel:setParent( parent )
	end
	
	panel.__children = {}
	panel.__hovered = false
	panel.__canClick = false
	panel.__clampDrawing = true
	panel.__x = 0
	panel.__y = 0
	panel.__w = 15
	panel.__h = 5
	panel.__class = base 
	
	gui.pos = gui.pos + 1
	local pos = gui.pos 
	panel.__id = pos
	gui.objects[ pos ] = panel

	panel:setZ( gui.getMaxZ() + 1 )
	panel:_initialize()
	panel:init()
	return panel 
end

--[[----------------------------------------
	gui.mergeGUIs( panel, base )
	Use to merge two different defined panels into one.
	Called internally, probably shouildn't be called.
--]]----------------------------------------
function gui.mergeGUIs( panel, base )
	local new_panel = {}
	new_panel = table.copy( gui.panels[ base ] )
	for k,v in pairs( panel ) do
		new_panel[ k ] = v
	end
return new_panel
end

function gui.cacheUI( name, panel, base, bValidBase )
	gui.cache[ #gui.cache +1 ] = { name, panel, base, bValidBase }
end 

function gui.checkCache( name )
	if #gui.cache > 0 then
		for i = 1,#gui.cache do
			if gui.cache[ i ][ 3 ] == name then 
				gui.cache[ i ][ 4 ] = true 
			end 
		end 
	end 
end 

function gui.loadCache()
	for i = 1,#gui.cache do
		if gui.cache[ i ][ 4 ] then
			gui.register( unpack( gui.cache[ i ] ) )
			gui.cache[ i ] = nil 
		end 
	end 
	if #gui.cache > 0 then
		gui.loadCache()
	end 
end 

--[[----------------------------------------
	gui.register( name, panel, base )
	Used to add panels to the global table.
--]]----------------------------------------
function gui.register( name, panel, base )
	if base then
		if not gui.panels[ base ] then 
			gui.cacheUI( name, panel, base )
		else 
			gui.panels[ name ] = gui.mergeGUIs( panel, base )
			gui.checkCache( name )
		end 
	else
		gui.panels[ name ] = panel
		gui.checkCache( name )
	end

	for i = 1,#gui.cache do
		if gui.cache[ i ][ 4 ] then 
			gui.panels[ gui.cache[ i ][ 1 ] ] = gui.mergeGUIs( gui.cache[ i ][ 2 ], gui.cache[ i ][ 3 ] )
			gui.cache[ i ] = nil 
		end 
	end 
end

function gui.getMaxZ()
	return gui._maxz 
end 

function gui.setMaxZ( num )
	gui._maxz = num 
end 

function gui.getMinZ()
	return gui._minz 
end 

function gui.setMinZ( num )
	gui._minz = num 
end 

function gui.setModal( pnl )
	gui.__modal = pnl 
end 

function gui.getModal()
	return gui.__modal 
end 

function gui.getObjects()
	return gui.objects 
end 

function gui.generateDrawOrder()
	local list = table.copyLight( gui.getObjects() )
	table.sort( list, function( t, t2 ) 
		return ( t and t2 and t:getZ() < t2:getZ() or false )
	end )
	gui.__drawOrder = list 
end 

function gui.getDrawOrder()
	return gui.__drawOrder or {}
end 

--Internal.
function gui.draw()
	local tbl = gui.getDrawOrder()
	for k,panel in pairs( tbl ) do
		local w,h = panel:getSize()
		local x,y = panel:getPos()

		lg.translate( x+1, y+1 )
			if panel.__clampDrawing then 
				lg.setScissor( x, y, w+2, h+4 )
			end
			panel:paint( w, h )
			panel:paintOver( w, h )
			lg.setScissor()
		lg.origin()
	end 
end

--Internal.
function gui.update()
	for k, panel in pairs( gui.objects ) do
		panel:think()
		panel:__mouseThink()
	end
end

--[[----------------------------------------
	Check to see if we clicked on a gui panel.
--]]----------------------------------------

function gui.buttonCheck( x, y, button )

	local in_area = util.isInArea
	local p = gui.getModal()
	if p then 
		local tbl = { p, unpack( p:getChildren() ) }
		local pnls = {}
		for k,v in pairs( tbl ) do 
			local p_x,p_y = v:getPos()
			local p_w,p_h = v:getSize()
			if in_area( x, y, p_x, p_y, p_w, p_h ) then
				pnls[ #pnls + 1 ] = v
			end
		end 

		local z = -math.huge 
		local targ = nil 
		for i = 1,#pnls do 
			local p2 = pnls[ i ]
			if p2:getZ() >= z then 
				z = p2:getZ()
				targ = p2 
			end 	
		end 

		if targ then 
			if targ:canClick() then 
				targ:__click( button )
			end 
			if not targ:isChild() then 
				targ:bringToFront()
			end 
		end
		return 
	end

	local tbl = {}
	for k, panel in pairs( gui.objects ) do
		local p_x,p_y = panel:getPos()
		local p_w,p_h = panel:getSize()
		if in_area( x, y, p_x, p_y, p_w, p_h ) then
			tbl[ #tbl + 1 ] = panel 
		end
	end

	local z = -math.huge 
	local p = nil 
	for i = 1,#tbl do
		local pnl = tbl[ i ]
		if pnl:getZ() >= z then 
			z = pnl:getZ()
			p = pnl 
		end 
	end 
	if p then 
		if p:canClick() then 
			p:__click( button )
		end 
		if not p:isChild() then 
			p:bringToFront()
		end 
	end

end
require("gui/_base")
require("gui/button")
require("gui/frame")
require("gui/label")
require("gui/panel")
require("gui/ynbox")