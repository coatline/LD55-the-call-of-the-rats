class_name ConversationData

var quotes : Array

func from_json(json_dict):
	quotes = []
	
	for talking_json in json_dict["quotes"]:
		var talking_instance = DialogueData.new()
		talking_instance.from_json(talking_json)
		quotes.append(talking_instance)
