extends StaticBody2D


func _ready():
	SignalBus.got_bike.connect(destroy)

func destroy():
	queue_free()
