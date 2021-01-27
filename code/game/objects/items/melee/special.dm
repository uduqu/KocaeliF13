

//branding rod
/obj/item/melee/classic_baton/branding
	name = "branding iron"
	desc = "An improvised branding iron. It bears the logo of the Legion at one end, with a button at the other. You know what to do, hopefully-not-Profligate."
	icon_state = "stunprod_nocell"
	item_state = "prod"
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
	slot_flags = ITEM_SLOT_BELT
	force = 1
	throwforce = 7
	w_class = WEIGHT_CLASS_HUGE//Not intended to be carried about.

/obj/item/melee/classic_baton/branding/attack(mob/living/target, mob/living/user)

	if(iscyborg(target))
		..()
		return

	if(!isliving(target))
		return

	if (user.a_intent == INTENT_HARM)
		if(!..())
			return
		if(!iscyborg(target))
			return

	else
		if(!do_after(user, 100, target = src) && cooldown <= world.time)
			if(target.getStaminaLoss() > 50)
				return
			if(ishuman(target))
				var/mob/living/carbon/human/H = target
				if (H.check_shields(src, 0, "[user]'s [name]", MELEE_ATTACK))
					return
				if(check_martial_counter(H, user))
					return
				playsound(get_turf(src), 'sound/effects/fuse.ogg', 75, 1, -1)
				target.adjustStaminaLoss(50)

				log_admin("[user] has branded [target] as a Legion Slave.")
				message_admins("<span class='adminnotice'>[user] has branded [target] as a Legion Slave.</span>")

				var/obj/item/worn = H.wear_id
				var/obj/item/card/id/id = null

				if(worn)
					id = worn.GetID()
				if(id)
					id.icon_state = "legionbrand"
					id.item_flags = NODROP
					id.desc = "Just another poor soul lost to the Legion."
					id.assignment = "Legion Slave"
					id.update_label()
				else
					id = new /obj/item/card/id/legionbrand(H.loc)
					id.registered_name = H.real_name
					id.assignment = "Legion Slave"
					id.desc = "Just another poor soul lost to the Legion."
					id.update_label()

					if(worn)
						if(istype(worn, /obj/item/pda))
							target.visible_message("<span class ='danger'>[user] attempts to brand [target] with [src], but fails due to an item being in the way!</span>", \
							"<span class ='userdanger'>[user] fails to brand [target] with [src] due to an item being in the way!</span>")
						else if(istype(worn, /obj/item/storage/wallet))
							target.visible_message("<span class ='danger'>[user] attempts to brand [target] with [src], but fails due to an item being in the way!</span>", \
							"<span class ='userdanger'>[user] fails to brand [target] with [src] due to an item being in the way!</span>")
					else
						H.equip_to_slot(id,SLOT_WEAR_ID)

				src.add_fingerprint(user)
				target.visible_message("<span class ='danger'>[user] brands [target] with [src]!</span>", \
					"<span class ='userdanger'>[user] brands [target] with [src]!</span>")
				if(!iscarbon(user))
					target.LAssailant = null
				else
					target.LAssailant = user
				cooldown = world.time + 10
