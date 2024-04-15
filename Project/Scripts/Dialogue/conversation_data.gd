class_name ConversationData

var dialogue_datas : Array[DialogueData]
var conversation_key : String
var repeatable : bool
var speaker_keys : Array
var shown_before : bool

func _init(json_dict, key : String):
	conversation_key = key
	
	dialogue_datas = []
	
	for talking_json in json_dict["quotes"]:
		var new_dialogue_data : DialogueData = DialogueData.new(talking_json)
		dialogue_datas.append(new_dialogue_data)
	
	if json_dict.has("repeatable"):
		repeatable = json_dict["repeatable"].to_lower() == "true"
	
	speaker_keys = json_dict["speakers"]
