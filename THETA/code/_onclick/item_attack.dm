GLOBAL_LIST_INIT(ru_dictionary, list(
	"struck"					= "�������",
	"pistol whipped"			= "�������������",
	"hit"						= "����",
	"attacked"					= "�������",
	"pricked"					= "���������",
	"struck"					= "���������",
	"absorbed"					= "��������",
	"gored"						= "�������",
	"robusted"					= "��������",
	"slashed"					= "�����",
	"stabbed"					= "�������",
	"sliced"					= "�����",
	"diced"						= "��������",
	"cut"						= "��������",
	"bashed"					= "�������"
	))
/proc/ru_attack_verb(var/attack_verb, var/item)
	. = attack_verb
	if(!attack_verb)
		return
	if(GLOB.ru_dictionary[attack_verb])
		return GLOB.ru_dictionary[attack_verb]
	log_admin("��� ����������� ��� ����� ��� ����� '[attack_verb]' ��� '[item]'")
