extends Node2D

@export var dialogue_trigger : DialogueTriggerer
@export var speaker : Speaker

var index = 0

func _ready():
	SignalBus.connect("picked_up_node", player_picked_up_node)
	GameData.bob = speaker

func player_picked_up_node(node):
	if node.name == "Shotty":
		dialogue_trigger.set_new_conversation_key("bob-after-shotty")

func _on_dialogue_trigger_started_conversation():
	#dialogue_trigger.conversation_key = ""
	pass
