extends Area2D

func interact():
	SignalBus.emit_signal("picked_up_node", self)
	queue_free()
