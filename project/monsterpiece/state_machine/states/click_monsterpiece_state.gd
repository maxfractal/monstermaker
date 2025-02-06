extends MonsterPieceState

func _enter():
	monsterpiece.color_rect.color = Color.ORANGE
	monsterpiece.label.text = "CLICKED"

func on_input(event):
	if event is InputEventMouseMotion:
		dbgLog.print("-------------CLICK: %s" % monsterpiece.name)
		# reparent while dragging
		#monsterpiece.reparent(get_tree().root.get_node("$Game"), true)
		#monsterpiece.z_index = 10;
		#monsterpiece.z_as_relative = false
		#monsterpiece.set_visibility_layer_bit(7,true)
		#
		# debug only
		#if get_tree().root != null:
			#dbgLog.print("parent has %s children" % monsterpiece.get_parent().get_child_count())
			#for child in monsterpiece.get_parent().get_children():
				#dbgLog.print("\t\t" + child.name)
		#
		transitioned.emit("Drag")
