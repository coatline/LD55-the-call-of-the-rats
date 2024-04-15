extends Node

var speaker_key_to_triggerers = {}
var speaker_key_to_speaker = {}

func _ready():
	get_references()
	
	SignalBus.picked_up_book.connect(got_book)
	SignalBus.gained_call_of_the_rats.connect(got_call_of_rats)
	SignalBus.picked_up_node.connect(picked_up_node)
	SignalBus.won_competition.connect(won_competition)
	
	get_triggerer("timothy").started_conversation.connect(talked_to_timothy)


func won_competition():
	get_triggerer("timothy").set_new_conversation_by_key("beat-timothy")


func talked_to_timothy(_conversationData : ConversationData):
	if _conversationData.conversation_key == "meet-timothy":
		get_triggerer("melinda").set_new_conversation_by_key("meet-melinda")
		get_triggerer("melinda2").set_new_conversation_by_key("meet-melinda")


func picked_up_node(node : Node2D):
	if node.name == "Shotty":
		get_triggerer("bob").set_new_conversation_by_key("bob-after-shotty")


func got_book():
	if GameData.has_call_of_the_rats == false:
		get_triggerer("melinda").set_new_conversation(null)
		get_triggerer("melinda2").set_new_conversation_by_key("melinda-again")


func got_call_of_rats():
	get_triggerer("melinda").set_new_conversation_by_key("melinda-after-ate-rat")
	get_triggerer("timothy").set_new_conversation_by_key("jimmy-intimidate-timothy")


func get_references():
	var dialogue_triggerers = get_tree().get_nodes_in_group("DialogueTriggerer")
	var speakers = get_tree().get_nodes_in_group("Speaker")

	for triggerer : DialogueTriggerer in dialogue_triggerers:
		speaker_key_to_triggerers[triggerer.speaker.speaker_key] = triggerer

	for speaker : Speaker in speakers:
		speaker_key_to_speaker[speaker.speaker_key] = speaker

func get_triggerer(speaker_key : String) -> DialogueTriggerer:
	return speaker_key_to_triggerers[speaker_key]

func get_speaker(speaker_key : String) -> Speaker:
	return speaker_key_to_speaker[speaker_key]
