class_name Bullet

extends Node2D

@onready var area_2d = $Area2D
@onready var sprite_2d = $Sprite2D
var force : Vector2
var initial_pos : Vector2
var dead : bool = false

func setup(force : Vector2):
	rotation_degrees = rad_to_deg(atan2(force.y, force.x)) + 90
	self.force = force
	initial_pos = global_position

func _physics_process(delta):
	if dead:
		sprite_2d.self_modulate.a -= delta * 8
		
		if sprite_2d.self_modulate.a <= 0:
			queue_free()
		return
	
	position += force
	if global_position.distance_to(initial_pos) > 55:
		dead = true
		area_2d.scale = Vector2.ZERO

func _on_area_2d_area_entered(area):
	if area as HitArea:
		area.hit()
	
	queue_free()
