extends RichTextLabel


func _ready():
	SignalBus.show_press_e.connect(show_e)
	SignalBus.hide_press_e.connect(hide_e)

func show_e():
	visible = true

func hide_e():
	visible = false
