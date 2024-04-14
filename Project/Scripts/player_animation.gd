extends AnimatedSprite2D

@export var player : Player
@export var shoot_behavior : ShootBehavior
@export var speaker : Speaker

func _process(delta):
	if speaker.active:
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

