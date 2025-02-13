#===============================================================================
# class: MonsterField
#
#	the play area to create a monster
#
# TODO
# - 
#===============================================================================
class_name MonsterField extends PieceField

#-------------------------------------------------------------------------------
# constants
#-------------------------------------------------------------------------------
#const DEBUG_MODE = true;

#-------------------------------------------------------------------------------
# variables
#-------------------------------------------------------------------------------
@onready var pieces_holder:= $MonsterPieces
@onready var bounce_piece := $MonsterPieces/bounce

#-------------------------------------------------------------------------------
# preloads
#-------------------------------------------------------------------------------
#var new_piece_scene = preload("res://project/monsterpiece/monster_piece.tscn")

#-------------------------------------------------------------------------------
# monster field functions
#-------------------------------------------------------------------------------
func test_load_piece_head():
	var texture_file_path = "res://art/Creatures/Pirate/SkeletonPirate_00_Head-straight.png"
	generate_piece(pieces_holder, texture_file_path)
	return;
func test_load_piece_arm():
	var texture_file_path = "res://art/Creatures/Pirate/SkeletonPirate_01_Arm-1-left.png"
	generate_piece(pieces_holder, texture_file_path)
	return;
	
#-------------------------------------------------------------------------------
# piece dragging + dropping
#-------------------------------------------------------------------------------
func return_monsterpiece_starting_position(piece: MonsterPiece):
	monsterpiece_reposition(piece)
	#pieces_holder.move_child(piece, piece.index)
	return;

func set_new_monsterpiece(piece: MonsterPiece):
	# NOTE: reparent MUST be BEFORE setting position!
	#
	piece.home_field = self
	monsterpiece_reposition(piece)
	return;

func monsterpiece_reposition(piece: MonsterPiece):
	dbgLog.print("-------------PART REPOSITION (monster field)")
	dbgLog.print("\tpiece local  mouse pos = %s" % piece.get_local_mouse_position())
	dbgLog.print("\tholdr local  mouse pos = %s" % pieces_holder.get_local_mouse_position())
	dbgLog.print("\tfield local  mouse pos = %s" % get_local_mouse_position())
	dbgLog.print("\tpiece global mouse pos = %s" % piece.get_global_mouse_position())
	dbgLog.print("\tpiece position         = %s" % piece.position)
	dbgLog.print("\tpiece global pos       = %s" % piece.global_position)
	dbgLog.print("\tpiece delta  pos       = %s" % (piece.get_global_mouse_position() - piece.global_position))
	#dbgLog.print("\tsize = %s" % piece.piece_texture_rect.size)
	dbgLog.print("\tfield local pos  = %s" % pieces_holder.position)
	dbgLog.print("\tfield screen pos = %s" % pieces_holder.global_position)
	dbgLog.print("\tdrop pt dectector= %s" % piece.drop_point_detector.position)
	dbgLog.print("\tdrop pt shape    = %s" % piece.drop_point_collision_shape.position)
	dbgLog.print("\tpieces holder  = %s" % pieces_holder.get_child_count())
	for child in pieces_holder.get_children():
		dbgLog.print("\t\tholder child = %s" % child.position + "  %s" % child.name)

	if (piece.get_parent() != pieces_holder):
		dbgLog.print("\t\treparent from %s" % piece.get_parent().name + "  to %s" % pieces_holder.name)
		piece.reparent(pieces_holder)

	#piece.pivot_offset = piece.get_global_mouse_position() - piece.global_position
	#piece.pivot_offset = Vector2(50,50)
	
	dbgLog.print("\tpiece pos before %s" % piece.position)
	dbgLog.print("\ttexturerect pos before %s" % piece.piece_texture_rect.position)
	dbgLog.print("\t---------position recalculation---------")
	
	#var index: int = 0;
	#index = pieces_holder.get_parent().get_index() + 1
	#pieces_holder.move_child(piece, piece.index)
	#dbgLog.print("child index %s " % index + " out of %s" % pieces_holder.get_parent().get_index())
	# new position calculation:
	#	mouse position - (field global position + 1/2 the field size) - (mouse position - piece global position)
	#
	var new_position
	#new_position = ((piece.get_global_mouse_position() - (self.global_position+(self.size/2))) - piece.get_local_mouse_position())
	new_position = pieces_holder.get_local_mouse_position()
	#(0,0) UL - new_position = (pieces_holder.get_local_mouse_position() - (piece.get_local_mouse_position() - pieces_holder.get_local_mouse_position()))
	#new_position = Vector2(50,50)

	if (bounce_piece != null):
		bounce_piece.set_position(new_position)
	update_piece_position( piece, new_position )

	dbgLog.print("\tnew pos          = %s" % new_position)
	dbgLog.print("\tpiece pos        = %s" % piece.position)
	dbgLog.print("\ttexturerect pos  = %s" % piece.piece_texture_rect.position)
	dbgLog.print("\tdrop pt dectector= %s" % piece.drop_point_detector.position)
	dbgLog.print("\tdrop pt shape    = %s" % piece.drop_point_collision_shape.position)
	dbgLog.print("\tpiece dectector  = %s" % piece.piece_detector.position)
	dbgLog.print("\tpiece parent     = %s" % piece.get_parent().name)
	dbgLog.print("\tpieces holder    = %s" % pieces_holder.get_child_count())
	for child in pieces_holder.get_children():
		dbgLog.print("\t\tholder child = %s" % child.name + "  %s" % child.position)
	dbgLog.print("===============")
	return;
	
#-------------------------------------------------------------------------------
# parent class functions
#-------------------------------------------------------------------------------
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("instantiate_piece1"):
		test_load_piece_head()
		return;
	if event.is_action_pressed("instantiate_piece2"):
		test_load_piece_arm()
		return;
	return;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	dbgLog.printRT("global mouse %s" % pieces_holder.get_global_mouse_position() + "\nlocal mouse %s" % pieces_holder.get_local_mouse_position())
	pass
