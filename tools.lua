
local itemuses = {}
itemuses["tincraft:tin_dagger"] = {uses = 8, group = "snappy", level = 1, strain = 2, fleshy = 4}
itemuses["tincraft:tin_spade"] = {uses = 10, group = "crumbly", level = 1, strain = 2, fleshy = 2}
itemuses["tincraft:tin_hatchet"] = {uses = 2, group = "choppy", level = 1, strain = 1, fleshy = 3}

itemuses["tincraft:tin_chisel"] = {uses = 10, level = 1, strain = 2, fleshy = 1}
itemuses["tincraft:chisel_mallet"] = {uses = 10, level = 1, strain = 2, fleshy = 1}
itemuses["tincraft:mallet_and_tin_chisel"] = {uses = 10, group = "cracky", level = 1, strain = 2, fleshy = 3}

local function tintool_capabilities(toolname)
	return {
		full_punch_interval = 2.0,
		max_drop_level = itemuses[toolname].level,
		damage_groups = {fleshy = itemuses[toolname].fleshy},
	}
end



local function use_tin_item(itemstack,user,pointedthing)
	local useprofile = itemuses[itemstack:get_name()]
	local maxuses = useprofile.uses
	local profiletype = useprofile.group
	local level = useprofile.level
	local strain = useprofile.strain

	if pointedthing.type == "object" then

		pointedthing.ref:punch(user, 1, tintool_capabilities(itemstack:get_name()) )

		-- IFF not a player, can check for regular bject
		if not pointedthing.ref:is_player() then
			local objname = pointedthing.ref:get_luaentity().name

			if objname == "__builtin:item" then
				return
			end
		end

		-- We have now acertained that it is either a player or a mob
		itemstack:add_wear(math.ceil(65536/math.ceil(maxuses*1.5)))
		return itemstack

	elseif pointedthing.type == "node" then
		local pos = pointedthing.under
		local node = minetest.get_node(pos)
		node = minetest.registered_nodes[node.name]

		if not minetest.is_protected(pos, user:get_player_name() )
				and minetest.get_item_group(node.name, profiletype) >= strain then

			minetest.remove_node(pos)
			local drop = node.drop
			if not drop then
				drop = node.name
			end

			minetest.add_item(pos, ItemStack(drop) )

			itemstack:add_wear(math.ceil(65536/maxuses))
			return itemstack
		end
	end
end

minetest.register_tool("tincraft:tin_dagger", {
        description = "Cheap Tin Dagger",
        inventory_image = "tincraft_tin_dagger.png",
	on_use = use_tin_item,
})

minetest.register_tool("tincraft:tin_spade", {
        description = "Toy Tin Spade",
        inventory_image = "tincraft_tin_spade.png",
	on_use = use_tin_item,
})

minetest.register_tool("tincraft:chisel_mallet", {
        description = "Chisel Mallet",
        inventory_image = "tincraft_chisel_mallet.png",
	on_use = use_tin_item,
})

minetest.register_tool("tincraft:tin_chisel", {
        description = "Brittle Tin Chisel",
        inventory_image = "tincraft_tin_chisel.png",
	on_use = use_tin_item,
})

minetest.register_tool("tincraft:mallet_and_tin_chisel", {
        description = "Mallet and Brittle Tin Chisel",
        inventory_image = "tincraft_mallet_and_tin_chisel.png",
	on_use = use_tin_item,
})

minetest.register_tool("tincraft:tin_hatchet", {
        description = "Weak Tin Hatchet",
        inventory_image = "tincraft_tin_hatchet.png",
	on_use = use_tin_item,
})

minetest.register_craft({
	output = "tincraft:tin_dagger",
	recipe = {
	{"moreores:tin_ingot"},
	{"moreores:tin_ingot"},
	{"default:stick"}
	}
})

minetest.register_craft({
	output = "tincraft:tin_spade",
	recipe = {
	{"moreores:tin_ingot"},
	{"default:stick"},
	{"default:stick"}
	}
})

minetest.register_craft({
	output = "tincraft:chisel_mallet",
	recipe = {
	{"group:tree"},
	{"default:stick"},
	}
})

minetest.register_craft({
	output = "tincraft:tin_chisel",
	recipe = {
	{"moreores:tin_ingot","moreores:tin_ingot","moreores:tin_ingot"},
	{"","default:stick",""},
	}
})

minetest.register_craft({
	output = "tincraft:mallet_and_tin_chisel",
	type = "shapeless",
	recipe = {"tincraft:tin_chisel","tincraft:chisel_mallet"},
})

minetest.register_craft({
	output = "tincraft:tin_hatchet",
	recipe = {
	{"moreores:tin_ingot","moreores:tin_ingot",""},
	{"moreores:tin_ingot","default:stick",""},
	{"","default:stick",""}
	}
})
