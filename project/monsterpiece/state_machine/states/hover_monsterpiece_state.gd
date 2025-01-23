extends MonsterPieceState


func _enter():
	monsterpiece.color_rect.color = Color.DARK_ORCHID
	monsterpiece.label.text = "hover"
	#print("_enter: " + monsterpiece.label.text)


func on_gui_input(event: InputEvent):
	if event.is_action_pressed("mouse_left"):
		monsterpiece.pivot_offset = monsterpiece.get_global_mouse_position() - monsterpiece.global_position
		#print("mouse gui input: " + monsterpiece.label.text + " -> click")
		transitioned.emit("Click")


func on_mouse_exited():
	#print("mouse exited: " + monsterpiece.label.text + " -> idle")
	transitioned.emit("Idle")
