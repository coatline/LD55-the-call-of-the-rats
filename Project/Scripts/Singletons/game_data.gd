extends Node

var has_call_of_the_rats : bool = false
var has_killed_rat : bool = false

var player : Player

var json_parser : JsonParser = JsonParser.new()

func get_conversation(key : String) -> ConversationData:
	return json_parser.get_conversation(key)
