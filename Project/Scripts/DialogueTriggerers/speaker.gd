class_name Speaker
extends Node2D

@export var speaker_name : String
@export var speaker_key : String
@export var speaker_settings : SpeakerSettings

@export var sprite2D : Sprite2D
@export var animatedSprite2D : AnimatedSprite2D

var active : bool

func set_is_active(b : bool):
	active = b

func try_update_emotion(emotion):
	if speaker_settings:
		speaker_settings.set_emotion(emotion, animatedSprite2D, sprite2D)
