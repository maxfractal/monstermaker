extends MonsterPieceState


func _enter():
	monsterpiece.color_rect.color = Color.WEB_GREEN
	monsterpiece.label.text = "Idle"
	monsterpiece.pivot_offset = Vector2.ZERO
	print("_enter: " + monsterpiece.label.text + " (%s)" % self)


func on_mouse_entered():
	print("mouse entered: " + monsterpiece.label.text + " -> hover")
	transitioned.emit("hover")
