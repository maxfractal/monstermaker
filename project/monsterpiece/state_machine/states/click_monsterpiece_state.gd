extends MonsterPieceState

func _enter():
	monsterpiece.color_rect.color = Color.ORANGE
	monsterpiece.label.text = "CLICKED"

func on_input(event):
	if event is InputEventMouseMotion:
		dbgLog.print("-------------CLICK: %s" % monsterpiece.name)
		# reparent while dragging
		var the_root = get_tree().root
		var parent_node = the_root.get_node("Game")
		monsterpiece.reparent(parent_node, true)
		#monsterpiece.z_index = 10;
		#monsterpiece.z_as_relative = false
		#monsterpiece.set_visibility_layer_bit(7,true)
		#
		# debug only
		#
		dbgLog.print("\troot has %s children" % the_root.get_child_count())
		if the_root != null:
			dbgLog.print("\troot %s" % the_root.name + " has %s children" % the_root.get_child_count())
			for child in the_root.get_children():
				dbgLog.print("\t\t" + child.name)
			dbgLog.print("\tparent %s" % monsterpiece.get_parent().name + " has %s children" % monsterpiece.get_parent().get_child_count())
			for child in monsterpiece.get_parent().get_children():
				dbgLog.print("\t\t" + child.name)
		#
		transitioned.emit("Drag")
