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
	piece.reparent(pieces_holder)
	pieces_holder.add_child(piece)

	print("\tglobal mouse pos = %s" % piece.get_global_mouse_position())
	print("\tsize = %s" % piece.size)
	print("\tfield local pos = %s" % pieces_holder.position)
	print("\tfield screen pos = %s" % pieces_holder.get_viewport().position)
	print("\tglobal pos = %s" % piece.global_position)
	print("\tdelta pos = %s" % (piece.get_global_mouse_position() - piece.global_position))
	piece.pivot_offset = piece.get_global_mouse_position() - piece.global_position
	print("\tpiece pos before %s" % piece.position)
	print("\ttexturerect pos before %s" % piece.piece_texture_rect.position)
	print("\t\t--------------")
	
	# this setting of position is shit!
	#
	#	there should be a way to set the root node of the piece and every child node
	# is relative.
	#
	#	also the calculation is garbage and should be more flexible
	#
	piece.setPosition(
		Vector2(-468,-322) + piece.global_position
		)
	print("\tpiece pos after  %s" % piece.position)
	print("\ttexturerect pos after %s" % piece.piece_texture_rect.position)
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
