class_name JsonParser

var dialogue_json_path = "res://dialogue.json"

var json_dict = {}
var conversation_dict = {}

func _init():
	json_dict = load_json_file()
	
	data_from_json()

func load_json_file():
	if FileAccess.file_exists(dialogue_json_path):
		var dataFile = FileAccess.open(dialogue_json_path, FileAccess.READ)
		var parsed_result = JSON.parse_string(dataFile.get_as_text())
		
		if parsed_result is Dictionary:
			return parsed_result
		else:
			assert(false, "couldn't load dialogue")
	else :
		assert(false, "file doesn't exists")

func data_from_json():
	for conversation_key in json_dict.keys():
		var conversation_data = ConversationData.new(json_dict[conversation_key], conversation_key)
		conversation_dict[conversation_key] = conversation_data

func get_conversation(key : String) -> ConversationData:
	if conversation_dict.has(key) == false:
		push_error("no conversation labeled: " + key)
		assert("no conversation labeled: " + key)
		return null
	
	return conversation_dict[key]
