extends Area2D

var interactables = []

func _on_area_entered(area : Area2D):
	if area.is_in_group("Interactable"):
		if interactables.size() == 0:
			SignalBus.emit_signal("show_press_e", area.global_position)
		
		interactables.append(area)

func _on_area_exited(area):
	if area.is_in_group("Interactable"):
		for i in range(interactables.size() - 1, 0):
			if i < 0: return
			var trigger = interactables[i]
			
			if trigger == area:
				interactables.remove_at(i)
				try_choose_another_trigger()

func _input(event):
	if event.is_action_pressed("interact"):
		if interactables.size() > 0:
			while interactables.size() > 0 and interactables[0] == null:
				interactables.remove_at(0)
			if interactables.size() == 0:
				return
			interactables[0].interact()
			interactables.remove_at(0)
			
			try_choose_another_trigger()

func try_choose_another_trigger():
	if interactables.size() == 0:
		SignalBus.emit_signal("hide_press_e")
	else:
		SignalBus.emit_signal("show_press_e", interactables[0])
