extends MonsterPieceState


func _enter():
	monsterpiece.color_rect.color = Color.DARK_ORCHID
	monsterpiece.label.text = "HOVER"


func on_gui_input(event: InputEvent):
	if event.is_action_pressed("mouse_left"):
		monsterpiece.pivot_offset = monsterpiece.get_global_mouse_position() - monsterpiece.global_position
		transitioned.emit("Click")


func on_mouse_exited():
	transitioned.emit("Idle")
