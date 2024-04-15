class_name HitArea

extends Area2D

@export var to_destroy : Node2D
var dead = false
signal died

func hit():
	if dead: return
	dead = true
	died.emit()
	to_destroy.queue_free()
