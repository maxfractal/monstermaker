extends MonsterPieceState


func _enter():
	monsterpiece.color_rect.color = Color.DARK_VIOLET
	monsterpiece.label.text = "Release"
	dbgLog.print("-------------RELEASE: %s" % monsterpiece.name)

	#When a monsterpiece is released, it checks where it is at the time of release.
	var field_areas = monsterpiece.drop_point_detector.get_overlapping_areas()
	#dbgLog.print("\t\tlooking for fields at %s" % monsterpiece.collision_shape.posi )
	# check where the piece got dropped:
	# - nowhere, original field, or new field
	#
	if field_areas.is_empty():
		# NO FIELD
		# if the piece is released and there is NOT a field below, return it to
		# it's original position
		#
		dbgLog.print("\tNo fields : piece : %s " % monsterpiece.name)
		
		monsterpiece.home_field.return_monsterpiece_starting_position(monsterpiece)
	elif field_areas[0].get_parent() == monsterpiece.home_field:
		# ORIGINAL FIELD
		# if there *IS* a field below and it is the same field it came from,
		# then reposition it in the current field
		dbgLog.print("\tsame field : %s " % monsterpiece.home_field.name ,"\tpiece : %s" % monsterpiece.name)
		monsterpiece.home_field.monsterpiece_reposition(monsterpiece)
	else:
		# NEW FIELD
		# Get the new field and parent to it, positioning it as needed.
		var new_field: PieceField = field_areas[0].get_parent()
		dbgLog.print("\tnew field : %s" % new_field.name ,"\tpiece : %s" % monsterpiece.name)
		new_field.set_new_monsterpiece(monsterpiece)

	transitioned.emit("idle")
