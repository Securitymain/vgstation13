//Helper object for picking dionaea (and other creatures) up.
// /obj/item/weapon/holder/animal works with ANY animal!

/obj/item/weapon/holder
	name = "holder"
	desc = "You shouldn't ever see this."
	inhand_states = list("left_hand" = 'icons/mob/in-hand/left/mob_holders.dmi', "right_hand" = 'icons/mob/in-hand/right/mob_holders.dmi')

	var/mob/stored_mob
	var/update_itemstate_on_twohand = FALSE //If there are different item states for holding this with one and two hands, this must be 1
	var/const/itemstate_twohand_suffix = "_2hand" //The item state

/obj/item/weapon/holder/New(loc, mob/M)
	..()
	processing_objects.Add(src)
	if(M)
		M.forceMove(src)

		src.stored_mob = M

/obj/item/weapon/holder/Destroy()
	//Hopefully this will stop the icon from remaining on human mobs.
	if(istype(loc,/mob/living))
		var/mob/living/A = src.loc
		A.drop_item(src, force_drop = TRUE)
		A.update_icons()

	for(var/mob/M in contents)
		M.forceMove(get_turf(src))
		if(M.client)
			M.client.eye = M

	processing_objects.Remove(src)
	..()

/obj/item/weapon/holder/supermatter_act(atom/source)
	if(stored_mob)
		stored_mob.supermatter_act(source, SUPERMATTER_DUST)
		qdel(stored_mob) //better safe than sorry, sorry mice.
	qdel(src)
	return TRUE

/obj/item/weapon/holder/process()
	if(!loc)
		return qdel(src)
	else if(istype(loc,/turf) || !(contents.len))
		return qdel(src)

/obj/item/weapon/holder/dropped()
	..()
	spawn(1) // im a cheater
		if(istype(loc,/turf) || !(contents.len))
			qdel(src)

/obj/item/weapon/holder/relaymove(mob/M, direction)
	qdel(src) //This calls Destroy(), and frees the mob

/obj/item/weapon/holder/attackby(var/obj/item/weapon/W, var/mob/user)
	for(var/mob/M in contents)
		M.attackby(W,user)

/obj/item/weapon/holder/update_wield(mob/user)
	..()

	if(update_itemstate_on_twohand)
		item_state = "[initial(item_state)][wielded ? itemstate_twohand_suffix : ""]"

		if(user)
			user.update_inv_hands()

/obj/item/weapon/holder/kick_act(mob/user)
	..()

	if(stored_mob)
		stored_mob.kick_act(user)

/obj/item/weapon/holder/bite_act(mob/user)
	if(stored_mob)
		stored_mob.bite_act(user)

//Nymph holder

/obj/item/weapon/holder/diona
	name = "diona nymph"
	desc = "It's a tiny plant critter."
	icon = 'icons/obj/objects.dmi'
	icon_state = "nymph"
	slot_flags = SLOT_HEAD
	origin_tech = Tc_MAGNETS + "=3;" + Tc_BIOTECH + "=5"

/obj/item/weapon/holder/diona/New(loc, mob/M)
	..()
	if(M)
		name = M.name

/obj/item/weapon/holder/animal
	name = "animal holder"
	desc = "This holder takes the mob's appearance, so it will work with any mob!"

/obj/item/weapon/holder/animal/New(loc, mob/M)
	..()
	if(M)
		appearance = M.appearance
		w_class = clamp((M.size - SIZE_TINY) * W_CLASS_MEDIUM, W_CLASS_TINY, W_CLASS_HUGE)
		//	SIZE		|	W_CLASS

		//	SIZE_TINY	|	W_CLASS_TINY
		//	SIZE_SMALL	|	W_CLASS_MEDIUM
		//	SIZE_NORMAL	|	W_CLASS_HUGE
		//	SIZE_BIG	|	W_CLASS_HUGE
		//	SIZE_HUGE	|	W_CLASS_HUGE

		throw_range = 6 - w_class

		if(w_class > W_CLASS_SMALL)
			flags |= (TWOHANDABLE | MUSTTWOHAND)

/obj/item/weapon/holder/animal/attackby(var/obj/item/weapon/W, var/mob/user)
	if (istype(W, /obj/item/offhand))
		for(var/mob/M in contents)
			M.attack_hand(user)
		return
	for(var/mob/M in contents)
		M.attackby(W,user)

/obj/item/weapon/holder/animal/attack_self(var/mob/user)
	for(var/mob/M in contents)
		M.attack_hand(user)

//MICE

/obj/item/weapon/holder/animal/mouse
	name = "mouse holder"
	desc = "This one has icon states!"
	slot_flags = SLOT_HEAD
	item_state = "mouse" //Credit to Hubblenaut for sprites! https://github.com/Baystation12/Baystation12/pull/9416

/obj/item/weapon/holder/animal/mouse/New(loc, mob/M)
	..()
	if(istype(M, /mob/living/simple_animal/mouse))
		var/mob/living/simple_animal/mouse/mouse = M

		item_state = initial(mouse.icon_state) //Initial icon states are "mouse_gray", "mouse_white", etc
		if(!(item_state in list("mouse_white", "mouse_brown", "mouse_gray", "mouse_black", "mouse_plague", "mouse_balbc", "mouse_operative")))
			item_state = "mouse_gray"

//CORGI

/obj/item/weapon/holder/animal/corgi
	name = "corgi holder"
	desc = "Icon states yay!"
	item_state = "corgi"

	update_itemstate_on_twohand = TRUE

/obj/item/weapon/holder/animal/mutt
	name = "sasha holder"
	item_state = "mutt"
	update_itemstate_on_twohand = TRUE

//CARP

/obj/item/weapon/holder/animal/carp
	name = "carp holder"
	item_state = "carp"

	update_itemstate_on_twohand = TRUE

//COWS

/obj/item/weapon/holder/animal/cow
	name = "cow holder"
	desc = "Pretty heavy!"
	item_state = "cow"

//CATS

/obj/item/weapon/holder/animal/cat
	name = "cat holder"
	desc = "RUNTIME ERROR"
	item_state = "cat1"

	update_itemstate_on_twohand = TRUE

//FROG

/obj/item/weapon/holder/animal/frog
	name = "frog holder"
	desc = "Don't hold it too tight."
	item_state = "frog"
	slot_flags = SLOT_HEAD

//SNAIL

/obj/item/weapon/holder/animal/snail
	name = "snail holder"
	desc = "Eh, it's all gooey and sticky."
	item_state = "snail"
	slot_flags = SLOT_HEAD

//SALEM

/obj/item/weapon/holder/animal/salem
	name = "salem holder"
	desc = "Esp!"
	item_state = "salem"

	update_itemstate_on_twohand = TRUE

//SNAKES

/obj/item/weapon/holder/animal/snek
	name = "snake holder"
	desc = "Kept you waiting?"
	item_state = "snek"

//SLIMES
/obj/item/weapon/holder/animal/slime
	name = "slime holder"
	desc = "It seeps through your fingers."

/obj/item/weapon/holder/animal/slime/proc/unfreeze()
	var/mob/living/simple_animal/slime/S = stored_mob
	S.canmove = TRUE
	S.icon_state = "[S.colour] [istype(S,/mob/living/simple_animal/slime/adult) ? "adult" : "baby"] slime"
	qdel(src)

/obj/item/weapon/holder/animal/slime/throw_impact(atom/hit_atom)
	if(!..())
		unfreeze()

/obj/item/weapon/holder/animal/slime/attack_self(mob/user)
	..()
	unfreeze()

/obj/item/weapon/holder/animal/pillow
	name = "pillow holder"
	desc = "Comfortable."
	item_state = "pillow"
	slot_flags = SLOT_HEAD
	update_itemstate_on_twohand = TRUE


/obj/item/weapon/holder/animal/borer
	name = "borer holder"
	desc = "It's wriggly and slimy."
	item_state = "borer"

/obj/item/weapon/holder/animal/borer/attack_self(mob/user)
	if(user.a_intent != I_HURT || user.zone_sel.selecting != "mouth")
		..()
		return

	user.visible_message("<span class='notice'>[user] bites the head off \the [stored_mob].</span>",\
	isjusthuman(user) ? "<span class='warning'>You bite the head off \the [stored_mob]. Disgusting.</span>" :\
	"<span class='notice'>You bite the head off \the [stored_mob]. Not bad!</span>")

	playsound(user, 'sound/effects/crunch_meat.ogg', 30, 0)
	blood_splatter(src,null,1)
	user.u_equip(src, 0)
	user.reagents.add_reagent(NUTRIMENT, 1)
	user.reagents.add_reagent(GREYGOO, 0.5)
	user.reagents.add_reagent(PERIDAXON, 0.5)

	var/obj/item/weapon/reagent_containers/food/snacks/meat/borer/B = new(get_turf(src))
	B.name = stored_mob.name

	if(fingerprints)
		B.fingerprints = fingerprints.Copy()
	if(fingerprintshidden)
		B.fingerprintshidden = fingerprintshidden.Copy()
	if(fingerprintslast)
		B.fingerprintslast = fingerprintslast

	user.put_in_active_hand(B)
	to_chat(stored_mob, "<span class='big danger'>Delicious!</span>")
	stored_mob.ghostize(0)
	qdel(stored_mob)
	qdel(src)

/obj/item/weapon/holder/animal/borer/relaymove(mob/M, direction)
	return			// There is no escape.
