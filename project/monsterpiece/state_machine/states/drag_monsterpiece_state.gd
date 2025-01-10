extends MonsterPieceState


func _enter():
	monsterpiece.color_rect.color = Color.BLUE
	monsterpiece.label.text = "DRAG"
	
	monsterpiece.index = monsterpiece.get_index()
	
	var canvas_layer := get_tree().get_first_node_in_group("fields")
	if canvas_layer:
		monsterpiece.reparent(canvas_layer)


func on_input(event: InputEvent):
	var mouse_motion := event is InputEventMouseMotion
	var confirm = event.is_action_released("mouse_left")
	
	if mouse_motion:
		monsterpiece.global_position = monsterpiece.get_global_mouse_position() - monsterpiece.pivot_offset
	
	if confirm:
		get_viewport().set_input_as_handled()
		transitioned.emit("Release")
