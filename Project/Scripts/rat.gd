class_name Rat
extends CharacterBody2D

#@export var audio : AudioStreamPlayer2D
#@export var sound : Sound

var rat_pickup = preload("res://Scenes/rat_pickup.tscn")
var flee_dist : float = 0
var speed : float = 0
var fleeing : bool = false
var fearless : bool = false

func _ready():
	speed = randf_range(15.0, 27.0)
	flee_dist = randf_range(25.0, 50.0)

func make_fearless():
	fearless = true
	speed = randf_range(20, 30)

func _on_rat_hit_area_died():
	
	var instance = rat_pickup.instantiate()
	instance.position = global_position
	get_tree().root.add_child(instance)
	
	if GameData.has_killed_rat == false:
		GameData.has_killed_rat = true
		SignalBus.start_conversation.emit(GameData.get_conversation("rat-killed"))
		SignalBus.killed_rat.emit(instance)
	
	queue_free()

func _physics_process(delta):
	var distance = global_position.distance_to(GameData.player.global_position)
	var direction_away_from_player = (global_position - GameData.player.global_position).normalized()
	
	if fearless:
		if distance >= 30:
			velocity = -direction_away_from_player * speed
		elif distance < 15:
			velocity = direction_away_from_player * speed
	elif fleeing:
		velocity = direction_away_from_player * speed
		
		if distance >= flee_dist * 2:
			fleeing = false
	elif distance < flee_dist:
		fleeing = true
	
	move_and_slide()
