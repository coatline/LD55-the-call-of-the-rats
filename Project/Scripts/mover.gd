class_name Mover
extends Node2D

@export var acceleration = 300.0
@export var max_speed = 35.0
@export var friction = 1.0

@export var characterBody : CharacterBody2D
@export var footstepper : AudioStreamPlayer2D
@export var sound : Sound

var current_acceleration : Vector2 = Vector2.ZERO
var input_velocity : Vector2 = Vector2.ZERO

func _physics_process(delta):
	if current_acceleration.length() > 0:
		characterBody.velocity += current_acceleration * delta
		characterBody.velocity = characterBody.velocity.limit_length(max_speed)
	else:
		characterBody.velocity *= delta * friction
	
	if current_acceleration.length() > 0:
		var direction = current_acceleration.normalized()
		
		var angle = rad_to_deg(atan2(direction.y, direction.x)) + 90
		var interval_angle = round(angle / 45.0) * 45.0
		
		characterBody.rotation_degrees = interval_angle
		
		if footstepper != null:
			footstepper.moved(sound.get_random())
	
	characterBody.move_and_slide()

func move(deltaVector : Vector2):
	current_acceleration = Vector2(deltaVector * acceleration)
