extends Control

@export var name_label : RichTextLabel
@export var dialogue_label : RichTextLabel
@export var next_arrow : RichTextLabel
@export var animation_player : AnimationPlayer
@export var camera : CameraFollow
@export var player : Player

var current_conversation : ConversationData
var other_speaker : Speaker = null
var other_position : Vector2 = Vector2.ZERO
var current_quote_index : int = 0
var unskippable : bool

var json_parser : JsonParser = JsonParser.new()

func _ready():
	SignalBus.connect("start_conversation", start_conversation)


func start_conversation(conversation_instance : ConversationInstance):
	if current_conversation != null: return
	
	other_position = conversation_instance.camera_position
	other_speaker = conversation_instance.speaker
	animation_player.play("show")
	camera.zoom_to(11)
	
	current_conversation = json_parser.get_conversation(conversation_instance.conversation_key)
	display_dialogue(current_conversation.quotes[current_quote_index])


func display_dialogue(dialogue_data : DialogueData):
	if dialogue_data.set_cam_pos:
		camera.move_to(Vector2(dialogue_data.cam_x, dialogue_data.cam_y))
		print(str(dialogue_data.cam_x) + " " + str(dialogue_data.cam_y))
	elif dialogue_data.speaking == "jimmy":
		camera.reset_position()
	else:
		camera.move_to(other_speaker.global_position)
	
	if dialogue_data.speaking == "jimmy":
		player.speaker.set_emotion(dialogue_data.emotion)
		other_speaker.set_emotion("")
	else:
		other_speaker.set_emotion(dialogue_data.emotion)
		player.speaker.set_emotion("")

	if current_quote_index <= 0 or current_conversation.quotes[current_quote_index - 1].speaking != dialogue_data.speaking:
		name_label.visible_characters = 0
	
	dialogue_label.visible_characters = 0
	unskippable = dialogue_data.unskippable
	
	next_arrow.visible = false
	
	name_label.text = "[center][wave amp=10.0]" + dialogue_data.speaking
	dialogue_label.text = "[center][wave amp=13.0]" + dialogue_data.quote


func end_conversation():
	# reset emotions
	other_speaker.set_emotion("")
	player.speaker.set_emotion("")
	
	# reset UI
	animation_player.play("hide")
	next_arrow.visible = false
	
	# reset camera
	camera.reset_zoom()
	camera.reset_position()
	
	current_conversation = null
	current_quote_index = 0
	SignalBus.emit_signal("conversation_over")

func _process(delta):
	var time = Time.get_ticks_msec()
	
	if current_conversation and time % 2 == 0:
		dialogue_label.visible_characters += 1
		name_label.visible_characters += 1
		
		if dialogue_label.visible_ratio >= 1:
			next_arrow.visible = true


func _input(event):
	if event is InputEvent:
		if event.is_action_pressed("interact"):
			if current_conversation != null:
				# the - 23 accounts for the bbcodes [center][wave amp=13.0]
				if dialogue_label.visible_characters < dialogue_label.text.length() - 23:
					if unskippable == false:
						dialogue_label.visible_characters = dialogue_label.text.length()
				else:
					# there are no more to show
					if current_quote_index + 1 >= current_conversation.quotes.size():
						end_conversation()
					else:
						current_quote_index += 1
						display_dialogue(current_conversation.quotes[current_quote_index])
