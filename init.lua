dofile(minetest.get_modpath("inventorbench") .. "/tools.lua")
minetest.register_craft({
    output = "inventorbench:bench",
    recipe = {
        {"default:wood", "default:steel_ingot", "default:wood"},
        {"default:wood", "default:wood", "default:wood"},
        {"default:wood", "default:wood", "default:wood"}
    }
})
minetest.register_node("inventorbench:bench", {
	description = "Inventor Bench",
	tile_images = {"inventor_bench_top.png","inventor_bench_side.png","inventor_bench_side.png","inventor_bench_side.png","inventor_bench_side.png","inventor_bench.png"},
	is_ground_content = true,
	groups = {oddly_breakable_by_hand=1},
	sounds = default.node_sound_stone_defaults(),
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec",
				"invsize[8,9;]"..
				"label[0,0;Inventor Bench]"..
				"list[current_name;main;4,1;3,3;]"..
				"list[current_player;main;0,5;8,4;]")
		meta:set_string("infotext", "Inventor Bench")
		local inv = meta:get_inventory()
		inv:set_size("main", 3*3)
	end
})
minetest.register_abm({
    nodenames = {"inventorbench:bench"},
    neighbors = {"anvil:anvil", "default:chest", "default:furnace", "default:furnace_active"},
    interval = 1,
    chance = 10,
    action = function(pos, node, active_object_count, active_object_count_wider)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	local invlist = inv:get_list("main")
	if invlist == {"default:steel_ingot 3", "default:stick 2"} then
		inv:remove_item("default:steel_ingot 3")
		inv:remove_item("default:stick 2")
		inv:add_item("inventorbench:stairpick")
	end
    end
})
