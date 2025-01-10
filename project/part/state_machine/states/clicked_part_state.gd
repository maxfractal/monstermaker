extends PartState


func _enter():
	part.color_rect.color = Color.ORANGE
	part.label.text = "CLICKED"


func on_input(event):
	if event is InputEventMouseMotion:
		transitioned.emit("Drag")
