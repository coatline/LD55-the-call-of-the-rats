class_name DialogueTriggerer
extends Area2D

@export var question_mark : RichTextLabel
@export var collision_shape : CollisionShape2D
@export var speakers : Array[Speaker]

@export var initial_conversation_key : String
@export var reusable : bool = false
var conversation_key : String

signal started_conversation

func _ready():
	set_new_conversation_key(initial_conversation_key)

func interact():
	question_mark.visible = false
	
	SignalBus.emit_signal("start_conversation", ConversationInstance.new(conversation_key, position, speakers))
	started_conversation.emit()
	
	if reusable == false:
		set_new_conversation_key("")

func set_new_conversation_key(new_key : String):
	conversation_key = new_key
	
	if new_key == "":
		question_mark.visible = false
		collision_shape.disabled = true
	else:
		if speakers[0].show_question_mark:
			question_mark.visible = true
		
		collision_shape.disabled = false

func _process(delta):
	if conversation_key == "":
		collision_shape.disabled = true
