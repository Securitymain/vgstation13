/spell/targeted/projectile/finger_gun
	name = "Finger Gun"
	abbreviation = "FG"
	desc = "Shoot a synthesized projectile straight from your fingertips. No, not spinning fingernails."
	user_type = USER_TYPE_OTHER

	proj_type = /obj/item/projectile/spell_projectile/invisible

	charge_max = 90
	spell_flags = IS_HARMFUL
	invocation = "pretends to fire a gun."
	invocation_type = SpI_EMOTE
	range = 20

	duration = 20
	projectile_speed = 0.5
	cast_prox_range = 0

	hud_state = "finger_gun"

/obj/item/projectile/spell_projectile/invisible
	name = "invisible shot"
	icon_state = null
	animate_movement = 0
	linear_movement = 0
	damage = 25


/obj/item/projectile/bullet/invisible
	name = "invisible bullet"
	icon_state = null
	damage = 25
	fire_sound = null
	embed = 0
	custom_impact = TRUE
