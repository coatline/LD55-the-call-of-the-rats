extends Node2D

@export var rat_scene : PackedScene

func spawn():
	var instance : Rat = rat_scene.instantiate()
	
	instance.make_fearless()
	instance.position = global_position
	get_tree().root.add_child(instance)
