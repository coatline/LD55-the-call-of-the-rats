class_name DialogueTriggerer
extends Node2D

signal started_conversation(conversationData : ConversationData)

@export var question_mark : RichTextLabel
@export var collision_shape : CollisionShape2D

@export var initial_conversation_key : String
@export var speaker : Speaker

var conv_data : ConversationData: set = set_data, get = get_data
var conversation_data : String

func get_data() -> ConversationData:
	return GameData.get_conversation(conversation_data)

func set_data(val : ConversationData):
	# print_stack()
	# print("setting to :" + str(val))
	if val == null:
		conversation_data = ""
	else: 
		conversation_data = val.conversation_key

func _ready():
	if initial_conversation_key != "":
		var initial_conv = GameData.get_conversation(initial_conversation_key)
		set_new_conversation(initial_conv)

func interact():
	if conv_data == null:
		# print("null data!!!")
		return
	
	if question_mark:
		question_mark.visible = false
	
	# print("interacted with: " + str(conv_data))
	
	SignalBus.start_conversation.emit(conv_data)
	started_conversation.emit(conv_data)
	
	if conv_data.repeatable == false:
		set_new_conversation(null)

func set_new_conversation(new_conv : ConversationData):
	conv_data = new_conv

	# if conv_data:
	# 	print("set to: " + conv_data.conversation_key)
	# else:
	# 	print("set to null")

	if conv_data == null:
		if question_mark:
			question_mark.visible = false
		collision_shape.disabled = true
	else:
		# don't show it if it has already been shown
		
		if conv_data.shown_before:
			if conv_data.repeatable == false:
				# print("was going to set to: " + conv_data.conversation_key + " but it's been shown before")
				set_new_conversation(null)
				return
		# only show question mark if we haven't seen it before
		elif question_mark:
			question_mark.visible = true
		
		#collision_shape.set_deferred("disabled",false)
		collision_shape.disabled = false

func set_new_conversation_by_key(key : String):
	# print("setting to: " + key + " from set_new_by_key and it's: "+str(GameData.get_conversation(key)))
	set_new_conversation(GameData.get_conversation(key))


# func _process(delta):
# 	if conversation_data != null and conversation_data.conversation_key == "bob-after-shotty":
# 		print(conversation_data)
