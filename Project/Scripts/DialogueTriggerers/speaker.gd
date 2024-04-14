class_name Speaker
extends Node

@export var speaker_name : String
@export var show_question_mark : bool
@export_group("AnimatedSprite2D")
@export var animatedSprite2D : AnimatedSprite2D
@export_group("Sprite2D")
@export var surprised_texture : Texture2D
@export var normal_texture : Texture2D
@export var sprite2D : Sprite2D

var active : bool = false

func set_emotion(emotion : String):
	active = emotion != ""
	
	if animatedSprite2D:
		if emotion == "":
			emotion = "idle"
		animatedSprite2D.play(emotion)
		return
	elif sprite2D:
		match(emotion):
			"":
				sprite2D.texture = normal_texture
			"surprised":
				sprite2D.texture = surprised_texture
