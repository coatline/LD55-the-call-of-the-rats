extends Node2D

@export var dialogue_ui : DialogueUI
@export var camera : CameraFollow
@export var player : Player
@export var boop_audio : AudioStreamPlayer2D
@export var surprised_audio : AudioStreamPlayer2D
@export var surprised_sound : Sound
@export var sound : Sound

var current_conversation : ConversationData
var current_speakers : Array[Speaker]

var current_quote_index : int = 0
var unskippable : bool


func _ready():
	SignalBus.start_conversation.connect(start_conversation)
	
	dialogue_ui.char_placed.connect(char_placed)

func char_placed():
	boop_audio.stream = sound.get_random()
	boop_audio.play()

func start_conversation(conv_data : ConversationData):
	if current_conversation != null or conv_data == null: return
	
	current_conversation = conv_data
	current_conversation.shown_before = true

	var speaker_keys : Array = current_conversation.speaker_keys

	for key : String in speaker_keys:
		var speaker : Speaker = DialogueTriggerManager.get_speaker(key)
		current_speakers.append(speaker)
		speaker.set_is_active(true)
	
	camera.zoom_to(11)
	
	display_dialogue(current_conversation.dialogue_datas[current_quote_index])


func display_dialogue(dialogue_data : DialogueData):
	for speaker : Speaker in current_speakers:
		if speaker.speaker_name == dialogue_data.speaking:
			
			if dialogue_data.set_cam_pos:
				camera.move_to(Vector2(dialogue_data.cam_x, dialogue_data.cam_y))
			else:
				camera.move_to(speaker.global_position)
			
			speaker.try_update_emotion(dialogue_data.emotion)
		else:
			speaker.try_update_emotion("")
	
	if dialogue_data.emotion != "":
		surprised_audio.stream = surprised_sound.get_random()
		surprised_audio.play()
	
	unskippable = dialogue_data.unskippable

	var reset_name_chars = current_quote_index <= 0 or current_conversation.dialogue_datas[current_quote_index - 1].speaking != dialogue_data.speaking
	dialogue_ui.display_dialogue(dialogue_data.speaking, dialogue_data.quote, reset_name_chars)


func end_conversation():
	# reset emotions
	for speaker : Speaker in current_speakers:
		speaker.try_update_emotion("")
		speaker.set_is_active(false)
	
	# reset camera
	camera.reset_zoom()
	camera.reset_position()
	
	SignalBus.conversation_ended.emit(current_conversation)
	current_conversation = null
	current_speakers = []
	current_quote_index = 0

func _input(event):
	if current_conversation == null: return
	
	if event is InputEvent:
		if event.is_action_pressed("interact"):
			# the - 23 accounts for the bbcodes [center][wave amp=13.0]
			if dialogue_ui.still_loading_dialogue():
				if unskippable == false:
					dialogue_ui.skip_dialogue()
			else:
				# there are no more to show
				if current_quote_index + 1 >= current_conversation.dialogue_datas.size():
					end_conversation()
				else:
					current_quote_index += 1
					display_dialogue(current_conversation.dialogue_datas[current_quote_index])
		elif event.is_action_pressed("skip_conversation"):
			end_conversation()
