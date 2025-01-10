extends PartState


func _enter():
	part.color_rect.color = Color.BLUE
	part.label.text = "DRAG"
	
	part.index = part.get_index()
	
	var canvas_layer := get_tree().get_first_node_in_group("fields")
	if canvas_layer:
		part.reparent(canvas_layer)


func on_input(event: InputEvent):
	var mouse_motion := event is InputEventMouseMotion
	var confirm = event.is_action_released("mouse_left")
	
	if mouse_motion:
		part.global_position = part.get_global_mouse_position() - part.pivot_offset
	
	if confirm:
		get_viewport().set_input_as_handled()
		transitioned.emit("Release")
