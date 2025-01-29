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

#-------------------------------------------------------------------------------
# preloads
#-------------------------------------------------------------------------------
#var new_piece_scene = preload("res://project/monsterpiece/monster_piece.tscn")

#-------------------------------------------------------------------------------
# piece dragging + dropping
#-------------------------------------------------------------------------------
func return_monsterpiece_starting_position(piece: MonsterPiece):
	piece.reparent(pieces_holder)
	pieces_holder.move_child(piece, piece.index)
	return;

func set_new_monsterpiece(piece: MonsterPiece):
	monsterpiece_reposition(piece)
	piece.home_field = self
	return;

func monsterpiece_reposition(piece: MonsterPiece):
	print("PART REPOSITION!")
	#var field_areas = piece.drop_point_detector.get_overlapping_areas()
	#var pieces_areas = piece.piece_detector.get_overlapping_areas()
	#var index: int = 0

	#if parts_areas.is_empty():
		##print(pieces_holder.has(part))
		##if field_areas.has(part):
			#index = pieces_holder.get_children().size()
	#elif parts_areas.size() == 1:
		#if field_areas.has(part):
			#index = parts_areas[0].get_parent().get_index()
		#else:
			#index = parts_areas[0].get_parent().get_index() + 1
	#else:
		#index = parts_areas[0].get_parent().get_index()
		#if index > parts_areas[1].get_parent().get_index():
			#index = parts_areas[1].get_parent().get_index()
		#
		#index += 1

	piece.reparent(pieces_holder)
	pieces_holder.add_child(piece)
	return;
	
#-------------------------------------------------------------------------------
# parent class functions
#-------------------------------------------------------------------------------
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
