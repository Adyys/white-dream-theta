GLOBAL_LIST_INIT(ru_dictionary, list(
	"struck"					= "�������",
	"pistol whipped"			= "�������������",
	"hit"						= "����",
	"bashed"					= "�������"
	))
/proc/ru_attack_verb(var/attack_verb)
	. = attack_verb
	if(!attack_verb)
		return
	if(GLOB.ru_dictionary[attack_verb])
		return GLOB.ru_dictionary[attack_verb]
	message_admins("��� ����������� ��� ����� ��� ����� '[attack_verb]'")
