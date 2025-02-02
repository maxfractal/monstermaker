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

	dbgLog.print("\tglobal mouse pos = %s" % piece.get_global_mouse_position())
	dbgLog.print("\tsize = %s" % piece.piece_texture_rect.size)
	dbgLog.print("\tfield local pos = %s" % pieces_holder.position)
	dbgLog.print("\tfield screen pos = %s" % pieces_holder.global_position)
	dbgLog.print("\tglobal pos = %s" % piece.global_position)
	dbgLog.print("\tdelta pos = %s" % (piece.get_global_mouse_position() - piece.global_position))
	
	piece.pivot_offset = piece.get_global_mouse_position() - piece.global_position
	
	dbgLog.print("\tpiece pos before %s" % piece.position)
	dbgLog.print("\ttexturerect pos before %s" % piece.piece_texture_rect.position)
	dbgLog.print("\t\t--------------")
	
	# new position calculation:
	#
	#	mouse position - (field global position + 1/2 the field size) - (mouse position - piece global position)
	#
	var new_position
	new_position = (piece.get_global_mouse_position() - (self.global_position+(self.size/2))) - (piece.get_global_mouse_position() - piece.global_position)
	piece.setPosition( new_position )
	
	dbgLog.print("\tpiece pos after  %s" % piece.position)
	dbgLog.print("\ttexturerect pos after %s" % piece.piece_texture_rect.position)
	dbgLog.print("===============")
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
