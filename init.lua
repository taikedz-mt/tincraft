-- Some crafts to make tin less useless.

tincraft = {}

function tcimport(filename)
	dofile(minetest.get_modpath("tincraft").."/"..filename)
end

tcimport("tools.lua")

if minetest.setting_getbool("tincraft.strongtin") then
	tcimport("strongtin.lua")
end
