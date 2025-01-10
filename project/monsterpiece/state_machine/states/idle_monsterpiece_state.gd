extends MonsterPieceState


func _enter():
	monsterpiece.color_rect.color = Color.WEB_GREEN
	monsterpiece.label.text = "Idle"
	monsterpiece.pivot_offset = Vector2.ZERO


func on_mouse_entered():
	transitioned.emit("hover")
