class_name Sound
extends Resource

@export var clips : Array[AudioStream]

func get_random():
	return clips.pick_random()

