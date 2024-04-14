class_name DialogueTriggerer
extends Area2D

@export var question_mark : RichTextLabel
@export var collision_shape : CollisionShape2D
@export var speaker : Speaker

@export var conversation_key : String
@export var reusable : bool = false

signal started_conversation


func _ready():
	if speaker.show_question_mark:
		question_mark.visible = true

func interact():
	if reusable == false:
		collision_shape.disabled = true
	
	question_mark.visible = false
	
	SignalBus.emit_signal("start_conversation", ConversationInstance.new(conversation_key, position, speaker))
	started_conversation.emit()

func set_new_conversation_key(new_key : String):
	collision_shape.disabled = false
	question_mark.visible = true
	conversation_key = new_key
