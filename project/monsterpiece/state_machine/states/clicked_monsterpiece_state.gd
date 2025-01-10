extends MonsterPieceState


func _enter():
	monsterpiece.color_rect.color = Color.ORANGE
	monsterpiece.label.text = "CLICKED"


func on_input(event):
	if event is InputEventMouseMotion:
		transitioned.emit("Drag")
