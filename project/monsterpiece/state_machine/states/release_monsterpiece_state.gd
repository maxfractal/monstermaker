extends MonsterPieceState


func _enter():
	monsterpiece.color_rect.color = Color.DARK_VIOLET
	monsterpiece.label.text = "Release"

	#When a monsterpiece is released, it checks where it is at the time of release.
	var field_areas = monsterpiece.drop_point_detector.get_overlapping_areas()

	if field_areas.is_empty():
		monsterpiece.home_field.return_card_starting_position(monsterpiece)
	elif field_areas[0].get_parent() == monsterpiece.home_field:
		monsterpiece.home_field.card_reposition(monsterpiece)
	else:
		var new_field: Field = field_areas[0].get_parent()
		new_field.set_new_monsterpiece(monsterpiece)

	transitioned.emit("idle")
