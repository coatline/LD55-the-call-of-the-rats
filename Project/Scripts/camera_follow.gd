class_name CameraFollow

extends Camera2D

@export var player : CharacterBody2D 

@export var zoom_speed = 5.0
@export var move_speed = 5.0
var target_zoom : float = 0.0
var regular_zoom : float = 0.0
var target_position : Vector2
var special_position = false

func _ready():
	regular_zoom = zoom.x
	target_zoom = regular_zoom
	target_position = player.position

func _process(delta):
	if special_position == false:
		target_position = player.position
	
	var zoom_amount : float = lerp(zoom.x, target_zoom, zoom_speed * delta)
	self.zoom = Vector2(zoom_amount, zoom_amount)
	
	position = lerp(position, target_position, move_speed * delta)

func reset_zoom():
	target_zoom = regular_zoom

func zoom_to(zoom_amount : float):
	target_zoom = zoom_amount

func reset_position():
	target_position = player.position
	special_position = false

func move_to(pos : Vector2):
	target_position = pos
	special_position = true

func move_delta(delta : Vector2):
	target_position += delta
