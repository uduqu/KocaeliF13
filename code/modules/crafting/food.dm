/obj/structure/campfire//adds the flag
	machine_tool_behaviour = list(TOOL_FIRE)

/datum/crafting_recipe/boiledwater
	name = "Water"
	result = /obj/item/bottledwater
	time = 160
	reqs = list(null)
	tools = list(TOOL_POT, TOOL_FIRE)
	category = CAT_FOOD
	subcategory = CAT_WASTEFOOD