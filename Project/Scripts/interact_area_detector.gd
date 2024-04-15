extends Area2D

@export var speaker : Speaker

@export var audio : AudioStreamPlayer2D
@export var pickup_sound : Sound
var interactables = []

func _on_area_entered(area : Area2D):
	if area.is_in_group("Interactable"):
		interactables.append(area)
		update_help_ui()

func _on_area_exited(area):
	if area.is_in_group("Interactable"):
		if interactables.has(area):
			interactables.erase(area)
			update_help_ui()

func _input(event):
	if speaker.active:
		return
	
	if event.is_action_pressed("interact"):
		if interactables.size() > 0:
			#if interactables[0].name == "Bob":
				#print("From interact: " + str(interactables[0].conversation_data))
			
			interactables[0].interact()
			interactables.remove_at(0)
			
			audio.stream = pickup_sound.get_random()
			audio.play()
			
			update_help_ui()

func update_help_ui():
	if interactables.size() == 0:
		SignalBus.hide_press_e.emit()
	else:
		SignalBus.show_press_e.emit()
