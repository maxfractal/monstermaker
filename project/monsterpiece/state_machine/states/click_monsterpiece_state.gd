extends MonsterPieceState

func _enter():
	monsterpiece.color_rect.color = Color.ORANGE
	monsterpiece.label.text = "CLICKED"

func on_input(event):
	if event is InputEventMouseMotion:
		print("CLICK: %s" % monsterpiece.name)
		# reparent while dragging
		#monsterpiece.reparent(get_tree().root.get_node("$GameCanvas"), true)
		monsterpiece.reparent(get_tree().root, true)
		#monsterpiece.z_index = 10;
		#monsterpiece.z_as_relative = false
		#monsterpiece.set_visibility_layer_bit(7,true)
		#
		transitioned.emit("Drag")
