extends Node

@export var collision_shape : CollisionShape2D

func _ready():
	SignalBus.gained_call_of_the_rats.connect(enable)

func enable():
	collision_shape.disabled = false

func interact():
	SignalBus.start_conversation.emit(ConversationInstance.new("use-call-of-the-rats", Vector2.ZERO, []))
	GameData.used_call = true
	queue_free()
