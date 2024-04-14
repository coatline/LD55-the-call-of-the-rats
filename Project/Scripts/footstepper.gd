extends AudioStreamPlayer2D

@export var min_time_between_footsteps = 0.23
@export var max_time_between_footsteps = 0.26

var footstep_timer = 0
var current_delay = 0

func _ready():
	current_delay = randf_range(min_time_between_footsteps, max_time_between_footsteps)

func _process(delta):
	footstep_timer += delta

func moved(clip : AudioStreamOggVorbis):
	if footstep_timer > current_delay:
		if playing == false:
			current_delay = randf_range(min_time_between_footsteps, max_time_between_footsteps)
			stream = clip
			footstep_timer = 0
			playing = true
