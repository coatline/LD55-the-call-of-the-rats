class_name ConversationInstance

var speaker : Speaker
var conversation_key : String
var camera_position : Vector2

func _init(conversation_key : String, camera_position : Vector2, _speaker : Speaker):
	self.conversation_key = conversation_key
	self.camera_position = camera_position
	self.speaker = _speaker
