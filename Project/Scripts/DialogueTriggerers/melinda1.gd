extends Node2D


@export var dialogue_triggerer: DialogueTriggerer
@export var timothy_triggerer : DialogueTriggerer
@export var melinda2_triggerer : DialogueTriggerer

func _ready():
	timothy_triggerer.connect("started_conversation", talked_to_timothy)
	melinda2_triggerer.connect("started_conversation", talked_to_melinda_2)

func talked_to_timothy():
	if GameData.player.knows_call_of_the_rats == false:
		dialogue_triggerer.set_new_conversation_key("meet-melinda")

func talked_to_melinda_2():
	melinda2_triggerer.set_new_conversation_key("")
