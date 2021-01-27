/turf/open/water
	gender = PLURAL
	name = "water"
	desc = "Shallow water."
	icon = 'icons/turf/floors.dmi'
	icon_state = "riverwater_motion"
	baseturfs = /turf/open/indestructible/ground/outside/desert
	initial_gas_mix = LAVALAND_DEFAULT_ATMOS
	planetary_atmos = TRUE
	slowdown = 25
	bullet_sizzle = TRUE
	bullet_bounce_sound = null //needs a splashing sound one day.
	light_range = 3
	light_power = 0.75
/*
/turf/open/water/Initialize()
	. = ..()
	MakeSlippery(TURF_WET_WATER, INFINITY, 0, INFINITY, TRUE)
*/

//radioactive
/turf/open/water/radioactive
	gender = PLURAL
	name = "radioactive water"
	desc = "Shallow, glowing water."
	icon = 'icons/turf/floors.dmi'
	icon_state = "riverwater_motion"
	baseturfs = /turf/open/indestructible/ground/outside/desert
	initial_gas_mix = LAVALAND_DEFAULT_ATMOS
	planetary_atmos = TRUE
	slowdown = 15
	light_color = LIGHT_COLOR_GREEN
	light_power = 0.5
	light_range = 0.2
	var/last_event = 0
	var/active = null

//beneath is ripped from uranium flooring code.
/turf/open/water/radioactive/Entered(var/mob/AM)
	.=..()
	if(!.)
		if(istype(AM))
			radiate()

/turf/open/water/radioactive/proc/radiate()
	if(!active)
		if(world.time > last_event+15)
			active = 1
			radiation_pulse(src, 10)
			for(var/turf/open/water/radioactive/T in orange(1,src))
				T.radiate()
			last_event = world.time
			active = 0
			return