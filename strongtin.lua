-- Make a more valuable tin product 

 
minetest.register_craftitem("tincraft:strong_tin", { 
        description = "Strengthened tin", 
        inventory_image = "moreores_tin_ingot.png^[colorize:violet:30" 
}) 
 
minetest.register_craftitem("tincraft:metalstonemix", { 
        description = "Metal and Stone Mix", 
        inventory_image = "default_coal_lump.png^[colorize:violet:50" 
}) 
 
minetest.register_craft({ 
        output = "tincraft:strong_tin", 
        recipe = { 
                {"moreores:tin_ingot","moreores:tin_ingot","moreores:tin_ingot"}, 
        } 
}) 


-- For those who have not been able to mine iron/are afraid of the first mining trip.
-- Making steel from tin is deliberately laborious.

minetest.register_craft({
        output = "tincraft:metalstonemix",
        recipe = {
                {"tincraft:strong_tin","default:stone","tincraft:strong_tin"},
                {"default:stone","tincraft:strong_tin","default:stone"},
                {"tincraft:strong_tin","default:stone","tincraft:strong_tin"},
        }
})

minetest.register_craft({
	type = "cooking",
	output = "default:iron_lump",
	recipe = "tincraft:metalstonemix",
	cooktime = 10,
})
