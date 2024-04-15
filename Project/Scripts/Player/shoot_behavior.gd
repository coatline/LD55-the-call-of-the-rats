class_name ShootBehavior
extends Node2D

@export var animatedSprite : AnimatedSprite2D
@export var shoot_effect : AnimatedSprite2D
@export var bullet_scene : PackedScene
@export var attack_point : Node2D
@export var bullet_count : int
@export var bullet_spread : float
@export var shoot_delay : float
@export var sound : Sound
@export var audio : AudioStreamPlayer2D

var shooting : bool = false

func fire():
	audio.stream = sound.get_random()
	audio.play()
	var normal = (attack_point.global_position - global_position).normalized()
	
	for x in range(0, 10):
		var instance : Bullet = bullet_scene.instantiate()
		
		var spread = Vector2(randf_range(-bullet_spread, bullet_spread), randf_range(-bullet_spread, bullet_spread))
		var randomized_normal = normal + spread
		instance.position = attack_point.global_position
		instance.setup(randomized_normal * 5)
		get_tree().root.add_child(instance)
	
	shoot_effect.visible = true
	shoot_effect.play("default")
	
	shooting = true
	animatedSprite.play("shoot")
	global_position -= normal * 3
	#mover.characterBody.velocity += (-normal * 50)
	await get_tree().create_timer(shoot_delay).timeout
	shooting = false
