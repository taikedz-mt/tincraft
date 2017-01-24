
local itemuses = {}
itemuses["tincraft:tin_dagger"] = {uses = 8, group = "snappy", level = 1, strain = 2, fleshy = 4}
itemuses["tincraft:tin_chisel"] = {uses = 5, group = "cracky", level = 1, strain = 2, fleshy = 3}
itemuses["tincraft:tin_spade"] = {uses = 6, group = "crumbly", level = 1, strain = 2, fleshy = 2}
itemuses["tincraft:tin_hatchet"] = {uses = 2, group = "choppy", level = 1, strain = 1, fleshy = 5}

local function tincaps(toolname)
	return {
		full_punch_interval = 2.0,
		max_drop_level = 0,
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
		local objname = pointedthing.ref:get_luaentity().name

		pointedthing.ref:punch(user, 1, tincaps(itemstack:get_name()) )

		if objname ~= "__builtin:item" then
			itemstack:add_wear(math.ceil(65536/math.ceil(maxuses*1.5)))
			return itemstack
		end

	elseif pointedthing.type == "node" then
		local pos = pointedthing.under
		local node = minetest.get_node(pos)
		node = minetest.registered_nodes[node.name]
		minetest.chat_send_all(dump(minetest.registered_nodes[node.name] ))

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
        description = "Cheap Dagger",
        inventory_image = "tincraft_tin_dagger.png",
	on_use = use_tin_item,
})

minetest.register_tool("tincraft:tin_spade", {
        description = "Toy Spade",
        inventory_image = "tincraft_tin_spade.png",
	on_use = use_tin_item,
})

minetest.register_tool("tincraft:tin_chisel", {
        description = "Brittle Chisel",
        inventory_image = "tincraft_tin_chisel.png",
	on_use = use_tin_item,
})

minetest.register_tool("tincraft:tin_hatchet", {
        description = "Weak Hatchet",
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
	output = "tincraft:tin_chisel",
	recipe = {
	{"moreores:tin_ingot","moreores:tin_ingot","moreores:tin_ingot"},
	{"","default:stick",""},
	{"","default:stick",""}
	}
})

minetest.register_craft({
	output = "tincraft:tin_hatchet",
	recipe = {
	{"moreores:tin_ingot","moreores:tin_ingot",""},
	{"moreores:tin_ingot","default:stick",""},
	{"","default:stick",""}
	}
})
