class_name DialogueUI
extends Control

@export var name_label : RichTextLabel
@export var dialogue_label : RichTextLabel
@export var next_arrow : RichTextLabel
@export var animation_player : AnimationPlayer

var in_conversation : bool

signal char_placed()

func _ready():
	SignalBus.start_conversation.connect(conversation_started)
	SignalBus.conversation_ended.connect(conversation_ended)

func conversation_started(_info):
	in_conversation = true
	animation_player.play("show")

func conversation_ended(_info):
	animation_player.play("hide")
	next_arrow.visible = false   
	in_conversation = false

func display_dialogue(speaker_name : String, quote : String, reset_name_chars : bool):
	
	if reset_name_chars:
		name_label.visible_characters = 0
	
	dialogue_label.visible_characters = 0
	next_arrow.visible = false
	name_label.text = "[center][wave amp=10.0]" + speaker_name
	dialogue_label.text = "[center][wave amp=13.0]" + quote


func still_loading_dialogue() -> bool:
	# the - 23 accounts for the bbcodes [center][wave amp=13.0]
	return (dialogue_label.visible_ratio < 0.99)

func skip_dialogue():
	dialogue_label.visible_characters = dialogue_label.text.length()
	next_arrow.visible = true

func _process(_delta):
	if in_conversation == false: return
	
	if dialogue_label.visible_ratio < 1 or name_label.visible_ratio < 1:
		var time = Time.get_ticks_msec()
		
		if time % 2 == 0:
			char_placed.emit()
			
			if dialogue_label.visible_ratio < 1:
				dialogue_label.visible_characters += 1
				if dialogue_label.visible_ratio >= 1:
					next_arrow.visible = true
				
			if name_label.visible_ratio < 1:
				name_label.visible_characters += 1
	
	
