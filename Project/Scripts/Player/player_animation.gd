class_name PlayerAnimation
extends AnimatedSprite2D

@export var player : Player
@export var shoot_behavior : ShootBehavior
@export var speaker : Speaker

var playing_special : bool = false

func _process(delta):
	
	if speaker.active:
		return
	
	if playing_special:
		return
	
	if player.can_move == false:
		return
	
	if shoot_behavior.shooting:
		return
	
	if player.velocity.length() > 0:
		if player.shotty_equipped:
			play("gun_walk")
		else:
			play("walk")
	else:
		if player.shotty_equipped:
			play("gun_idle")
		else:
			play("idle")

func play_anim_for(animation_name : String, duration : float):
	playing_special = true
	play(animation_name)
	await get_tree().create_timer(duration).timeout
	playing_special = false
