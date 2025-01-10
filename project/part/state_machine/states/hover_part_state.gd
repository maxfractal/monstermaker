extends PartState


func _enter():
	part.color_rect.color = Color.DARK_ORCHID
	part.label.text = "HOVER"


func on_gui_input(event: InputEvent):
	if event.is_action_pressed("mouse_left"):
		part.pivot_offset = part.get_global_mouse_position() - part.global_position
		transitioned.emit("Click")


func on_mouse_exited():
	transitioned.emit("Idle")
