/obj/item/assembly/primer
	name = "priming device"
	desc = "A small electronic device able to prime all grenades in a same container."
	icon_state = "igniter"

/obj/item/assembly/primer/activate()
	if(!..())
		return FALSE//Cooldown check

	if(!istype(holder.loc, /obj/item/storage))
		return

	for(var/obj/item/grenade/G in holder.loc.contents)
		G.prime()

	return TRUE
