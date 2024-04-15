class_name DialogueData

var speaking : String
var quote : String
var set_cam_pos : bool
var cam_x : float
var cam_y : float
var emotion : String
var unskippable : bool

func _init(json_dict):
	speaking = json_dict["speaking"]
	quote = json_dict["quote"]
	
	if json_dict.has("cam_x"):
		set_cam_pos = true
		cam_x = json_dict["cam_x"] as float
	if json_dict.has("cam_y"):
		set_cam_pos = true
		cam_y = json_dict["cam_y"] as float
	if json_dict.has("emotion"):
		emotion = json_dict["emotion"]
	if json_dict.has("unskippable"):
		unskippable = json_dict["unskippable"].to_lower() == "true"
