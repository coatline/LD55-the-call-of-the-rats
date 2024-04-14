extends RichTextLabel


func _ready():
	SignalBus.connect("show_press_e", show_at)
	SignalBus.connect("hide_press_e", hide_e)

func show_at(pos : Vector2):
	position = pos
	visible = true

func hide_e():
	visible = false
