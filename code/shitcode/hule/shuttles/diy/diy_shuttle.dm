GLOBAL_VAR_INIT(diy_shuttle_count, 0)

/obj/docking_port/mobile/diy
	name = "DIY"
	id = "diy_autism"
	dir = 2
	port_direction = 2
	width = 13
	height = 24
	dwidth = 6
	dheight = 23

/obj/docking_port/mobile/diy/Initialize()
	id += "[GLOB.diy_shuttle_count]"
	. = ..()

/obj/machinery/computer/camera_advanced/shuttle_docker/adv/diy
	name = "Do-It-Yourself shuttle navigation console"
	desc = "Used to designate a precise transit location."
	shuttleId = "diy_autism"
	shuttlePortId = "diy_autism_custom"
	jumpto_ports = list()
	dir = 1
	x_offset = 15
	y_offset = 0
	z_lock = list(2,3,4,7,8,9,10,12)

/obj/machinery/computer/camera_advanced/shuttle_docker/adv/diy/Initialize()
	shuttleId += "[GLOB.diy_shuttle_count]"
	shuttlePortId += "[GLOB.diy_shuttle_count]"
	. = ..()
	GLOB.jam_on_wardec += src

/obj/machinery/computer/camera_advanced/shuttle_docker/adv/diy/Destroy()
	GLOB.jam_on_wardec -= src
	return ..()

/obj/machinery/computer/shuttle/diy
	name = "Do-It-Yourself shuttle movement console"
	shuttleId = "diy_autism"
	possible_destinations = "diy_autism_home;diy_autism_custom"
	dir = 1

/obj/machinery/computer/shuttle/diy/Initialize()
	shuttleId += "[GLOB.diy_shuttle_count]"
	possible_destinations += "[GLOB.diy_shuttle_count]"
	. = ..()

/obj/docking_port/stationary/diy
	name = "DIY stationary"
	id = "diy_autism_home"
	dir = 2
	width = 13
	height = 24
	dwidth = 6
	dheight = 23

/area/shuttle/diy
	name = "Do-It-Yourself shuttle"
	requires_power = TRUE
	valid_territory = FALSE

/datum/map_template/shuttle/capsule/diyshuttle
	name = "Autism Shuttle"
	description = "Priv"

	shuttle_id = "autism"
	port_id = "diy_autism"
	prefix = "code/shitcode/hule/shuttles/diy/"
	suffix = "diy_autism.dmm"

/obj/item/shuttlespawner/diyshuttle
	name = "bluespace shuttle capsule"
	desc = "Priva."
	template_id = "autism"
	template = new /datum/map_template/shuttle/capsule/diyshuttle

/obj/item/shuttlespawner/diyshuttle/Initialize()
	. = ..()
	template.port_id += "[GLOB.diy_shuttle_count]"

/obj/item/shuttlespawner/diyshuttle/attack_self()
	. = ..()
	if(used)
		GLOB.diy_shuttle_count++