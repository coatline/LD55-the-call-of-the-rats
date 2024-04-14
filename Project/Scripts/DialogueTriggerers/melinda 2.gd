extends Node2D

@export var dialogue_triggerer: DialogueTriggerer


func _ready():
	SignalBus.picked_up_book.connect(got_book)
	GameData.melinda_2 = dialogue_triggerer.speakers[0]

func got_book():
	dialogue_triggerer.set_new_conversation_key("melinda-again")
