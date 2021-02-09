minetest.register_craftitem("inventorbench:stairpick", {
    description = "Stairpick",
    inventory_image = "stairpick.png",
    sound = {breaks = "default_tool_breaks"},
	on_use = function(itemstack, user, pointed_thing)
		local player_name = user:get_player_name()
		if pointed_thing.type == "node" then
			local node_under = minetest.get_node(pointed_thing.under).name
			local nodedef = minetest.registered_nodes[node_under]
			if not nodedef then
				return
			end
			if minetest.is_protected(pointed_thing.under, player_name) then
				minetest.chat_send_player(player_name, "This area is protected")
				return
			end
            if minetest.get_node(pointed_thing.under).name == "default:wood" then
                minetest.set_node(pointed_thing.under, {name = "stairs:stair_wood"})
            if not minetest.is_creative_enabled(player_name) then
			    local wdef = itemstack:get_definition()
		    	itemstack:add_wear(128)
			end
			return itemstack
		end
	end
})
