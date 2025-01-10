extends PartState


func _enter():
	part.color_rect.color = Color.DARK_VIOLET
	part.label.text = "Release"

	#When a part is released, it checks where it is at the time of release.
	var field_areas = part.drop_point_detector.get_overlapping_areas()

	if field_areas.is_empty():
		part.home_field.return_part_starting_position(part)
	elif field_areas[0].get_parent() == part.home_field:
		part.home_field.part_reposition(part)
	else:
		var new_field: Field = field_areas[0].get_parent()
		new_field.set_new_part(part)

	transitioned.emit("idle")
