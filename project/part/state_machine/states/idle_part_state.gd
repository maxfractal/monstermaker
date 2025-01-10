extends PartState


func _enter():
	part.color_rect.color = Color.WEB_GREEN
	part.label.text = "Idle"
	part.pivot_offset = Vector2.ZERO


func on_mouse_entered():
	transitioned.emit("hover")
