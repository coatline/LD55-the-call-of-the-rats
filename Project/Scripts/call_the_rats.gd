extends Node2D

@export var collision_shape : CollisionShape2D
@export var sprite_2D : Sprite2D
@export var audio : AudioStreamPlayer2D
@export var sound : Sound
var activated : bool

func _ready():
	SignalBus.gained_call_of_the_rats.connect(enable)

func enable():
	collision_shape.disabled = false
	sprite_2D.visible = true

func interact():
	SignalBus.start_conversation.emit(GameData.get_conversation("use-call-of-the-rats"))
	activated = true
	audio.stream = sound.get_random()
	audio.play()
	await get_tree().create_timer(1.5).timeout
	queue_free()

func _process(delta):
	rotation_degrees += delta * 20
	
	if activated:
		scale += Vector2.ONE * (delta * 7.5)
		modulate.a -= delta / 1.5
