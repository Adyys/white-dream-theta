//predominantly negative traits

/datum/quirk/badback
	name = "������� �����"
	desc = " ��������� ����� ������ ������ ������ ������� ����� �������� ������."
	value = -2
	mood_quirk = TRUE
	gain_text = "<span class='danger'>���� ����� ����� ������ �����!</span>"
	lose_text = "<span class='notice'>���� ����� ��������� ���� �����...</span>"
	medical_record_text = "������������ �������� ��� ���������, ��� ��� ����� ������ �����."

/datum/quirk/badback/on_process()
	var/mob/living/carbon/human/H = quirk_holder
	if(H.back && istype(H.back, /obj/item/storage/backpack))
		SEND_SIGNAL(quirk_holder, COMSIG_ADD_MOOD_EVENT, "back_pain", /datum/mood_event/back_pain)
	else
		SEND_SIGNAL(quirk_holder, COMSIG_CLEAR_MOOD_EVENT, "back_pain")

/datum/quirk/blooddeficiency
	name = "������� �����"
	desc = "��� �������� �� ����� ����������� ���������� ����� ��� ����������� ����������������."
	value = -2
	gain_text = "<span class='danger'>�� ���������� ��������.</span>"
	lose_text = "<span class='notice'>�� ���������� ���� ������!</span>"
	medical_record_text = " �������� ���������� �������������� ������ ��� ����������� ����� ��-�� � �������� � ��� ���������."

/datum/quirk/blooddeficiency/on_process()
	var/mob/living/carbon/human/H = quirk_holder
	if(NOBLOOD in H.dna.species.species_traits) //can't lose blood if your species doesn't have any
		return
	else
		if (H.blood_volume > (BLOOD_VOLUME_SAFE - 25)) // just barely survivable without treatment
			H.blood_volume -= 0.275

/datum/quirk/blindness
	name = "������"
	desc = "�� ��������� �����. ������ �� ����� ����������������� �����."
	value = -4
	gain_text = "<span class='danger'>�� ������ �� ������!</span>"
	lose_text = "<span class='notice'>�� �������� ������� ����� ������!</span>"
	medical_record_text = "������� ����� ���������� �������."

/datum/quirk/blindness/add()
	quirk_holder.become_blind(ROUNDSTART_TRAIT)

/datum/quirk/blindness/on_spawn()
	var/mob/living/carbon/human/H = quirk_holder
	var/obj/item/clothing/glasses/blindfold/white/B = new(get_turf(H))
	if(!H.equip_to_slot_if_possible(B, SLOT_GLASSES, bypass_equip_delay_self = TRUE)) //if you can't put it on the user's eyes, put it in their hands, otherwise put it on their eyes
		H.put_in_hands(B)
	H.regenerate_icons()

/datum/quirk/brainproblems
	name = "������� � ������"
	desc = "� ����� ������ ������ ��������� ������, ������� �������� ���������� ��� ����. ����� ������ � ����� ��������!"
	value = -3
	gain_text = "<span class='danger'>�� ���������� ���� � ������.</span>"
	lose_text = "<span class='notice'>�� ����������, ��� ������ ��������� ������.</span>"
	medical_record_text = "������� ����� �������� � ����� ������, ������� �������� �������� ��� ����, ��� � ������ ������� ����� �������� � ������ ��������."

/datum/quirk/brainproblems/on_process()
	quirk_holder.adjustOrganLoss(ORGAN_SLOT_BRAIN, 0.2)

/datum/quirk/deafness
	name = "����������"
	desc = "�� ������ �� �������."
	value = -2
	mob_trait = TRAIT_DEAF
	gain_text = "<span class='danger'>�� �� ������ ������ �������.</span>"
	lose_text = "<span class='notice'>������ �� ����� �������!</span>"
	medical_record_text = "������ � ���� �������� ���������� � �� ������������ �������."

/datum/quirk/depression
	name = "������������"
	desc = "������ �� ������ ���������� ���� �����."
	mob_trait = TRAIT_DEPRESSION
	value = -1
	gain_text = "<span class='danger'>�� ���������� ���� ������������.</span>"
	lose_text = "<span class='notice'>�� ������ �� ���������� ���� ������������.</span>" // ���� ���� ��� ���� ��� �����!
	medical_record_text = "������� ����� ��������� ����������� �����������, � ���������� ���� � ���� ��������� ������ ������� ���������."
	mood_quirk = TRUE

/datum/quirk/depression/on_process()
	if(prob(0.05))
		SEND_SIGNAL(quirk_holder, COMSIG_ADD_MOOD_EVENT, "depression", /datum/mood_event/depression)

/datum/quirk/family_heirloom
	name = "�������� ��������"
	desc = "�� ��������� ���������� �������� ��������, ������� ��������� �� ��������� � ���������. ����� ������� ��� � �����!"
	value = -1
	mood_quirk = TRUE
	var/obj/item/heirloom
	var/where
	medical_record_text = "������� ������������� �������������� ������������� � ��� �������� ��������."

/datum/quirk/family_heirloom/on_spawn()
	var/mob/living/carbon/human/H = quirk_holder
	var/obj/item/heirloom_type

	if(is_species(H, /datum/species/moth) && prob(50))
		heirloom_type = /obj/item/flashlight/lantern/heirloom_moth
	else
		switch(quirk_holder.mind.assigned_role)
			//Service jobs
			if("Clown")
				heirloom_type = /obj/item/bikehorn/golden
			if("Mime")
				heirloom_type = /obj/item/reagent_containers/food/snacks/baguette
			if("Janitor")
				heirloom_type = pick(/obj/item/mop, /obj/item/clothing/suit/caution, /obj/item/reagent_containers/glass/bucket)
			if("Cook")
				heirloom_type = pick(/obj/item/reagent_containers/food/condiment/saltshaker, /obj/item/kitchen/rollingpin, /obj/item/clothing/head/chefhat)
			if("Botanist")
				heirloom_type = pick(/obj/item/cultivator, /obj/item/reagent_containers/glass/bucket, /obj/item/storage/bag/plants, /obj/item/toy/plush/beeplushie)
			if("Bartender")
				heirloom_type = pick(/obj/item/reagent_containers/glass/rag, /obj/item/clothing/head/that, /obj/item/reagent_containers/food/drinks/shaker)
			if("Curator")
				heirloom_type = pick(/obj/item/pen/fountain, /obj/item/storage/pill_bottle/dice)
			if("Assistant")
				heirloom_type = /obj/item/storage/toolbox/mechanical/old/heirloom
			//Security/Command
			if("Captain")
				heirloom_type = /obj/item/reagent_containers/food/drinks/flask/gold
			if("Head of Security")
				heirloom_type = /obj/item/book/manual/wiki/security_space_law
			if("Warden")
				heirloom_type = /obj/item/book/manual/wiki/security_space_law
			if("Security Officer")
				heirloom_type = pick(/obj/item/book/manual/wiki/security_space_law, /obj/item/clothing/head/beret/sec)
			if("Detective")
				heirloom_type = /obj/item/reagent_containers/food/drinks/bottle/whiskey
			if("Lawyer")
				heirloom_type = pick(/obj/item/gavelhammer, /obj/item/book/manual/wiki/security_space_law)
			//RnD
			if("Research Director")
				heirloom_type = /obj/item/toy/plush/slimeplushie
			if("Scientist")
				heirloom_type = /obj/item/toy/plush/slimeplushie
			if("Roboticist")
				heirloom_type = pick(subtypesof(/obj/item/toy/prize)) //look at this nerd
			//Medical
			if("Chief Medical Officer")
				heirloom_type = pick(/obj/item/clothing/neck/stethoscope, /obj/item/bodybag)
			if("Medical Doctor")
				heirloom_type = pick(/obj/item/clothing/neck/stethoscope, /obj/item/bodybag)
			if("Chemist")
				heirloom_type = /obj/item/book/manual/wiki/chemistry
			if("Virologist")
				heirloom_type = /obj/item/reagent_containers/syringe
			//Engineering
			if("Chief Engineer")
				heirloom_type = pick(/obj/item/clothing/head/hardhat/white, /obj/item/screwdriver, /obj/item/wrench, /obj/item/weldingtool, /obj/item/crowbar, /obj/item/wirecutters)
			if("Station Engineer")
				heirloom_type = pick(/obj/item/clothing/head/hardhat, /obj/item/screwdriver, /obj/item/wrench, /obj/item/weldingtool, /obj/item/crowbar, /obj/item/wirecutters)
			if("Atmospheric Technician")
				heirloom_type = pick(/obj/item/lighter, /obj/item/lighter/greyscale, /obj/item/storage/box/matches)
			//Supply
			if("Quartermaster")
				heirloom_type = pick(/obj/item/stamp, /obj/item/stamp/denied)
			if("Cargo Technician")
				heirloom_type = /obj/item/clipboard
			if("Shaft Miner")
				heirloom_type = pick(/obj/item/pickaxe/mini, /obj/item/shovel)

	if(!heirloom_type)
		heirloom_type = pick(
		/obj/item/toy/cards/deck,
		/obj/item/lighter,
		/obj/item/dice/d20)
	heirloom = new heirloom_type(get_turf(quirk_holder))
	var/list/slots = list(
		"� ����� ����� �������" = SLOT_L_STORE,
		"� ����� ������ �������" = SLOT_R_STORE,
		"� ����� �����" = SLOT_IN_BACKPACK
	)
	where = H.equip_in_one_of_slots(heirloom, slots, FALSE) || "� ����� ���"

/datum/quirk/family_heirloom/post_add()
	if(where == "� ����� �����")
		var/mob/living/carbon/human/H = quirk_holder
		SEND_SIGNAL(H.back, COMSIG_TRY_STORAGE_SHOW, H)

	to_chat(quirk_holder, "<span class='boldnotice'>������� ��� ��� �������� [heirloom.name] [where], ������������ �� ��������� � ���������. ������� � ������������!</span>")

	var/list/names = splittext(quirk_holder.real_name, " ")
	var/family_name = names[names.len]

	heirloom.AddComponent(/datum/component/heirloom, quirk_holder.mind, family_name)

/datum/quirk/family_heirloom/on_process()
	if(heirloom in quirk_holder.GetAllContents())
		SEND_SIGNAL(quirk_holder, COMSIG_CLEAR_MOOD_EVENT, "family_heirloom_missing")
		SEND_SIGNAL(quirk_holder, COMSIG_ADD_MOOD_EVENT, "family_heirloom", /datum/mood_event/family_heirloom)
	else
		SEND_SIGNAL(quirk_holder, COMSIG_CLEAR_MOOD_EVENT, "family_heirloom")
		SEND_SIGNAL(quirk_holder, COMSIG_ADD_MOOD_EVENT, "family_heirloom_missing", /datum/mood_event/family_heirloom_missing)

/datum/quirk/family_heirloom/clone_data()
	return heirloom

/datum/quirk/family_heirloom/on_clone(data)
	heirloom = data

/datum/quirk/frail
	name = "�����"
	desc = "���� ����� ���-����� ������� �� ������! ���� ���������� �� ������ ��������� ����� �����������."
	value = -2
	mob_trait = TRAIT_EASYLIMBDISABLE
	gain_text = "<span class='danger'>�� ���������� ���� ������.</span>"
	lose_text = "<span class='notice'>�� ����� ���������� ���� �������..</span>"
	medical_record_text = "������� ����� ����� ������ �����, ������������� ��������� �����."

/datum/quirk/heavy_sleeper
	name = "������� ���"
	desc = " �� ������ �����! ������ ���, ����� �� �������� ����� ��� ������� ��������, ��� ����������� ������� ������ �������, ����� ������."
	value = -1
	mob_trait = TRAIT_HEAVY_SLEEPER
	gain_text = "<span class='danger'>�� ���������� ���� �����.</span>"
	lose_text = "<span class='notice'>�� ����� ���������� ���� ������!</span>"
	medical_record_text = "������� ����� ������������� ���������� �������� ��� � ��� ������ ���������."

/datum/quirk/hypersensitive
	name = "�������������������"
	desc = "������ �� ���, ��� �����, �� ������� �� ���� ���������� ���������� ����� �������, ��� ������ ����."
	value = -1
	gain_text = "<span class='danger'>��, �������, ������ ������� �������� �������� �� �����.</span>"
	lose_text = "<span class='notice'>��� ������ �� ������� ���������� ������.</span>"
	medical_record_text = "������� ������������� ������� �������� ����������."

/datum/quirk/hypersensitive/add()
	var/datum/component/mood/mood = quirk_holder.GetComponent(/datum/component/mood)
	if(mood)
		mood.mood_modifier += 0.5

/datum/quirk/hypersensitive/remove()
	if(quirk_holder)
		var/datum/component/mood/mood = quirk_holder.GetComponent(/datum/component/mood)
		if(mood)
			mood.mood_modifier -= 0.5

/datum/quirk/light_drinker
	name = "������� ����������� ��������"
	desc = "� ��� ������ ������������ � �������� � �� ����� ������ ����������� ������."
	value = -1
	mob_trait = TRAIT_LIGHT_DRINKER
	gain_text = "<span class='notice'>���� ����� �� �������� ���������� ���� ������ ��������.</span>"
	lose_text = "<span class='danger'>�� ������ �� ��������� �� ��������.</span>"
	medical_record_text = "������� ������������� ������ ������������ � ��������."

/datum/quirk/nearsighted //t. errorage
	name = "����������"
	desc = "�� ��������� ��� �����, �� ����������� � ����� ����� �����."
	value = -1
	gain_text = "<span class='danger'>���� ������� ������� ��� ������ �������������.</span>"
	lose_text = "<span class='notice'>���� ������� ������ ����� ����� �����.</span>"
	medical_record_text = "�������� ���������� ������ ���� �����, ����� �� �������� �� ������������."

/datum/quirk/nearsighted/add()
	quirk_holder.become_nearsighted(ROUNDSTART_TRAIT)

/datum/quirk/nearsighted/on_spawn()
	var/mob/living/carbon/human/H = quirk_holder
	var/obj/item/clothing/glasses/regular/glasses = new(get_turf(H))
	H.put_in_hands(glasses)
	H.equip_to_slot(glasses, SLOT_GLASSES)
	H.regenerate_icons() //this is to remove the inhand icon, which persists even if it's not in their hands

/datum/quirk/nyctophobia
	name = "������ �������"
	desc = "��������� �� �������, �� ������ ������� �������. ������ � ������� ��� �����, �� ������ ����������� ����� � ����� ���� ���������"
	value = -1
	medical_record_text = "������� ������������� ����� � �������."

/datum/quirk/nyctophobia/on_process()
	var/mob/living/carbon/human/H = quirk_holder
	if(H.dna.species.id in list("shadow", "nightmare"))
		return //we're tied with the dark, so we don't get scared of it; don't cleanse outright to avoid cheese
	var/turf/T = get_turf(quirk_holder)
	var/lums = T.get_lumcount()
	if(lums <= 0.2)
		if(quirk_holder.m_intent == MOVE_INTENT_RUN)
			to_chat(quirk_holder, "<span class='warning'>���, ��������, ��������... ������ ���������...</span>")
			quirk_holder.toggle_move_intent()
		SEND_SIGNAL(quirk_holder, COMSIG_ADD_MOOD_EVENT, "nyctophobia", /datum/mood_event/nyctophobia)
	else
		SEND_SIGNAL(quirk_holder, COMSIG_CLEAR_MOOD_EVENT, "nyctophobia")

/datum/quirk/nonviolent
	name = "��������"
	desc = "����� � ������� ���������� ��� ����������� ���� ���������. ���������, ��� �� �� ������ ������� ���� ����������."
	value = -2
	mob_trait = TRAIT_PACIFISM
	gain_text = "<span class='danger'>�� ���������� ���� �����, ������� � �������!</span>"
	lose_text = "<span class='notice'>�� ����������, ��� �� ������ �������� ���� �����.</span>"
	medical_record_text = "������� �������� ���������� � �� ����� ��������� ���� ��������� ���� ����-����."

/datum/quirk/paraplegic
	name = "�������"
	desc = "���� ���� �� �������������. ������ �� ����� ������ ��� ����� ������ �� ����. �� ���� � ��� ���� ���������� ���������� �������!"
	value = -3
	human_only = TRUE
	gain_text = null // Handled by trauma.
	lose_text = null
	medical_record_text = "������� �������� ��������� ������ �����������.."

/datum/quirk/paraplegic/add()
	var/datum/brain_trauma/severe/paralysis/paraplegic/T = new()
	var/mob/living/carbon/human/H = quirk_holder
	H.gain_trauma(T, TRAUMA_RESILIENCE_ABSOLUTE)

/datum/quirk/paraplegic/on_spawn()
	if(quirk_holder.buckled) // Handle late joins being buckled to arrival shuttle chairs.
		quirk_holder.buckled.unbuckle_mob(quirk_holder)

	var/turf/T = get_turf(quirk_holder)
	var/obj/structure/chair/spawn_chair = locate() in T

	var/obj/vehicle/ridden/wheelchair/wheels = new(T)
	if(spawn_chair) // Makes spawning on the arrivals shuttle more consistent looking
		wheels.setDir(spawn_chair.dir)

	wheels.buckle_mob(quirk_holder)

	// During the spawning process, they may have dropped what they were holding, due to the paralysis
	// So put the things back in their hands.

	for(var/obj/item/I in T)
		if(I.fingerprintslast == quirk_holder.ckey)
			quirk_holder.put_in_hands(I)

/datum/quirk/poor_aim
	name = "����� ����������"
	desc = "�� �� ������ ���������� � ������� � �� ������ ������� ������ ������� ���� �������� ����� �����. Dual-wielding is right out."
	value = -1
	mob_trait = TRAIT_POOR_AIM
	medical_record_text = "� �������� ������� ����� � ����� �����."

/datum/quirk/prosopagnosia
	name = "�������������"
	desc = "�� ������ ����������� ������������, ������� ������ ��� ������������ ����."
	value = -1
	mob_trait = TRAIT_PROSOPAGNOSIA
	medical_record_text = "������� �������� �� ������������� � �� ����� ������ ����."

/datum/quirk/prosthetic_limb
	name = "������ ����������"
	desc = "� ����� � ���������� � �������, �� �������� ���� �� ����� �����������. �� ������� ����, � ��� ������� ������ ���� ����������!"
	value = -1
	var/slot_string = "limb"
	medical_record_text = "�� ����� ����������� ������������ � �������� ��� ��������� ������."

/datum/quirk/prosthetic_limb/on_spawn()
	var/limb_slot = pick(BODY_ZONE_L_ARM, BODY_ZONE_R_ARM, BODY_ZONE_L_LEG, BODY_ZONE_R_LEG)
	var/mob/living/carbon/human/H = quirk_holder
	var/obj/item/bodypart/old_part = H.get_bodypart(limb_slot)
	var/obj/item/bodypart/prosthetic
	switch(limb_slot)
		if(BODY_ZONE_L_ARM)
			prosthetic = new/obj/item/bodypart/l_arm/robot/surplus(quirk_holder)
			slot_string = "����� ����"
		if(BODY_ZONE_R_ARM)
			prosthetic = new/obj/item/bodypart/r_arm/robot/surplus(quirk_holder)
			slot_string = "������ ����"
		if(BODY_ZONE_L_LEG)
			prosthetic = new/obj/item/bodypart/l_leg/robot/surplus(quirk_holder)
			slot_string = "����� ����"
		if(BODY_ZONE_R_LEG)
			prosthetic = new/obj/item/bodypart/r_leg/robot/surplus(quirk_holder)
			slot_string = "������ ����"
	prosthetic.replace_limb(H)
	qdel(old_part)
	H.regenerate_icons()

/datum/quirk/prosthetic_limb/post_add()
	to_chat(quirk_holder, "<span class='boldannounce'>���� [slot_string] ���� �������� ��������. ��� ������� � ����� ����� �������� ��� ��������� �����-���� ����. ����� ��������, \
	��� ��� ����� ����� ������������ ��������� ���������� � ������ ��� ������� �������, ������ ������������ ��������� � �����.</span>")

/datum/quirk/pushover
	name = "�����������"
	desc = "��� ������ �������� ����� ��������� ����� ������� ���. ���������� �� ������� ����� ����� �������."
	value = -2
	mob_trait = TRAIT_GRABWEAKNESS
	gain_text = "<span class='danger'>�� ���������� ���� ������������.</span>"
	lose_text = "<span class='notice'>������-�� �� ������ ����� ���� ����� �����</span>"
	medical_record_text = "������� ������������ ����� ����������� � ������� ��������, � �� ����� ��������������."

/datum/quirk/insanity
	name = "������� ����������� ����������"
	desc = "�� ��������� �� ���������� ������������ ������������, ������� �������� ����� ������� ������������. �������� \"������������\" ������� ��� �������� ��� �������, � �� �������������� � �������� \"�������������\". <b>��� �� �������� ��������� �� ����..</b>"
	value = -2
	//no mob trait because it's handled uniquely
	gain_text = "<span class='userdanger'>...</span>"
	lose_text = "<span class='notice'>�� ���������� ���� ����������..</span>"
	medical_record_text = "������� �������� �� �������� ����������� ����������, ���������� � ���� ������� ������������."

/datum/quirk/insanity/on_process()
	if(quirk_holder.reagents.has_reagent(/datum/reagent/toxin/mindbreaker, needs_metabolizing = TRUE))
		quirk_holder.hallucination = 0
		return
	if(prob(2)) //we'll all be mad soon enough
		madness()

/datum/quirk/insanity/proc/madness()
	quirk_holder.hallucination += rand(10, 25)

/datum/quirk/insanity/post_add() //I don't /think/ we'll need this but for newbies who think "roleplay as insane" = "license to kill" it's probably a good thing to have
	if(!quirk_holder.mind || quirk_holder.mind.special_role)
		return
	to_chat(quirk_holder, "<span class='big bold info'>������, ��� ��� ������� ����������� �� ��� ��� ����� �������� �� ������ �����, ��� �����-������ ������� ������� ����� ����������. \
�� �� ����������, � ������� ���� ��� ��� ��������� �� ���, ��� �� ��������� �������..</span>")

/datum/quirk/social_anxiety
	name = "���������� �����������"
	desc = "�������� � ������ ����� ������ ��� ���, � �� ������ ������ ���������, ��� ���� ������ �������."
	value = -1
	gain_text = "<span class='danger'>�� ��������� ����������� ������ ������ ����������.</span>"
	lose_text = "<span class='notice'>��� ����� ����� ��������.</span>" //if only it were that easy!
	medical_record_text = "�������, ��� �������, ����������� � ���������� ������ � ������������ �������� ��."
	var/dumb_thing = TRUE

/datum/quirk/social_anxiety/on_process()
	var/nearby_people = 0
	for(var/mob/living/carbon/human/H in oview(3, quirk_holder))
		if(H.client)
			nearby_people++
	var/mob/living/carbon/human/H = quirk_holder
	if(prob(2 + nearby_people))
		H.stuttering = max(3, H.stuttering)
	else if(prob(min(3, nearby_people)) && !H.silent)
		to_chat(H, "<span class='danger'>�� ������� ������ ������� ���������. ��� <i>������</i> �� ������� �������������.</span>")
		H.silent = max(10, H.silent)
	else if(prob(0.5) && dumb_thing)
		to_chat(H, "<span class='userdanger'>�� ����������� �������� ����, ������� ������� ������ ����� � ��������� �������.</span>")
		dumb_thing = FALSE //only once per life
		if(prob(1))
			new/obj/item/reagent_containers/food/snacks/spaghetti/pastatomato(get_turf(H)) //��� ����'5 ���� 1 ��11 5�������1 ����.

/datum/quirk/junkie
	name = "��������"
	desc = "�� ��������� �� ������������� �����������."
	value = -2
	gain_text = "<span class='danger'>�������� �� ������������� ���� � ����������.</span>"
	lose_text = "<span class='notice'>��� ����� ������� ��������� ���������, �������� ��.</span>"
	medical_record_text = "������� �������� �� ����������� � ������� ����������."
	var/drug_list = list(/datum/reagent/drug/crank, /datum/reagent/drug/krokodil, /datum/reagent/medicine/morphine, /datum/reagent/drug/happiness, /datum/reagent/drug/methamphetamine) //List of possible IDs
	var/datum/reagent/reagent_type //!If this is defined, reagent_id will be unused and the defined reagent type will be instead.
	var/datum/reagent/reagent_instance //! actual instanced version of the reagent
	var/where_drug //! Where the drug spawned
	var/obj/item/drug_container_type //! If this is defined before pill generation, pill generation will be skipped. This is the type of the pill bottle.
	var/obj/item/drug_instance //! instanced version of the container
	var/where_accessory //! where the accessory spawned
	var/obj/item/accessory_type //! If this is null, an accessory won't be spawned.
	var/obj/item/accessory_instance //! instanced version of the accessory
	var/process_interval = 30 SECONDS //! how frequently the quirk processes
	var/next_process = 0 //! ticker for processing

/datum/quirk/junkie/on_spawn()
	var/mob/living/carbon/human/H = quirk_holder
	if (!reagent_type)
		reagent_type = pick(drug_list)
	reagent_instance = new reagent_type()
	H.reagents.addiction_list.Add(reagent_instance)
	var/current_turf = get_turf(quirk_holder)
	if (!drug_container_type)
		drug_container_type = /obj/item/storage/pill_bottle
	drug_instance = new drug_container_type(current_turf)
	if (istype(drug_instance, /obj/item/storage/pill_bottle))
		var/pill_state = "pill[rand(1,20)]"
		for(var/i in 1 to 7)
			var/obj/item/reagent_containers/pill/P = new(drug_instance)
			P.icon_state = pill_state
			P.reagents.add_reagent(reagent_type, 1)

	if (accessory_type)
		accessory_instance = new accessory_type(current_turf)
	var/list/slots = list(
		"� ����� ����� �������" = SLOT_L_STORE,
		"� ����� ������ �������" = SLOT_R_STORE,
		"� ����� �����" = SLOT_IN_BACKPACK
	)
	where_drug = H.equip_in_one_of_slots(drug_instance, slots, FALSE) || "� ����� ���"
	if (accessory_instance)
		where_accessory = H.equip_in_one_of_slots(accessory_instance, slots, FALSE) || "� ����� ���"
	announce_drugs()

/datum/quirk/junkie/post_add()
	if(where_drug == "� ����� �����" || where_accessory == "� ����� �����")
		var/mob/living/carbon/human/H = quirk_holder
		SEND_SIGNAL(H.back, COMSIG_TRY_STORAGE_SHOW, H)

/datum/quirk/junkie/proc/announce_drugs()
	to_chat(quirk_holder, "<span class='boldnotice'>�� �������� [drug_instance.name] �� [reagent_instance.name] [where_drug]. ����� �� ����������...</span>")

/datum/quirk/junkie/on_process()
	var/mob/living/carbon/human/H = quirk_holder
	if(world.time > next_process)
		next_process = world.time + process_interval
		if(!H.reagents.addiction_list.Find(reagent_instance))
			if(!reagent_instance)
				reagent_instance = new reagent_type()
			else
				reagent_instance.addiction_stage = 0
			H.reagents.addiction_list += reagent_instance
			to_chat(quirk_holder, "<span class='danger'>�� �������� ������ [reagent_instance.name] �����...</span>")

/datum/quirk/junkie/smoker
	name = "���������"
	desc = "������ ��� ������ ������� ��������. ��������, �� �����-�� � ������� ��� ����� ������."
	value = -1
	gain_text = "<span class='danger'>��� ����� ����� ��������.</span>"
	lose_text = "<span class='notice'>�� ����������, ��� �� ������� �������� ������..</span>"
	medical_record_text = "������� �������� �����������.."
	reagent_type = /datum/reagent/drug/nicotine
	accessory_type = /obj/item/lighter/greyscale

/datum/quirk/junkie/smoker/on_spawn()
	drug_container_type = pick(/obj/item/storage/fancy/cigarettes,
		/obj/item/storage/fancy/cigarettes/cigpack_midori,
		/obj/item/storage/fancy/cigarettes/cigpack_uplift,
		/obj/item/storage/fancy/cigarettes/cigpack_robust,
		/obj/item/storage/fancy/cigarettes/cigpack_robustgold,
		/obj/item/storage/fancy/cigarettes/cigpack_carp)
	. = ..()

/datum/quirk/junkie/smoker/announce_drugs()
	to_chat(quirk_holder, "<span class='boldnotice'>����� ������� [drug_instance.name] [where_drug], � ����������� [where_accessory]. ���������, ��� �� ��������� ��� ������� �����, ���� ��� ����������.</span>")


/datum/quirk/junkie/smoker/on_process()
	. = ..()
	var/mob/living/carbon/human/H = quirk_holder
	var/obj/item/I = H.get_item_by_slot(SLOT_WEAR_MASK)
	if (istype(I, /obj/item/clothing/mask/cigarette))
		var/obj/item/storage/fancy/cigarettes/C = drug_instance
		if(istype(I, C.spawn_type))
			SEND_SIGNAL(quirk_holder, COMSIG_CLEAR_MOOD_EVENT, "wrong_cigs")
			return
		SEND_SIGNAL(quirk_holder, COMSIG_ADD_MOOD_EVENT, "wrong_cigs", /datum/mood_event/wrong_brand)

/datum/quirk/unstable
	name = "������������"
	desc = "� ����� � �������� ����������, �� ������ �� ������� ������� ���� �������, ���� ����� ������� ����������. ������ ����� ���������� � ��������� ���� ����������!"
	value = -2
	mob_trait = TRAIT_UNSTABLE
	gain_text = "<span class='danger'>������� ����� ������ � ������...</span>"
	lose_text = "<span class='notice'>�� ���������� ���� ������� ���������.</span>"
	medical_record_text = "������� �������� ��������� � �������� ��������� � �� ������ ������ ���������� ����� ������."