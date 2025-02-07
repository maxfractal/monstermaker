#===============================================================================
# class: PieceField
#
#	parent class to hold Monster Pieces.  This could be an ordered library or 
#	Monster creation area.
#
# TODO
# - 
#===============================================================================
class_name PieceField extends MarginContainer
#extends Field

#-------------------------------------------------------------------------------
# constants
#-------------------------------------------------------------------------------
#const DEBUG_MODE = true;

#-------------------------------------------------------------------------------
# variables
#-------------------------------------------------------------------------------
#@onready var pieces_scroller: ScrollContainer = $MarginContainer/PartsScrollContainer

#-------------------------------------------------------------------------------
# preloads
#-------------------------------------------------------------------------------
# load the monster piec

#-------------------------------------------------------------------------------
# class virtual functions
#-------------------------------------------------------------------------------
func monsterpiece_reposition(piece: MonsterPiece) -> void:
	pass
	
func return_monsterpiece_starting_position(part: MonsterPiece) -> void:
	pass

func set_new_monsterpiece(part: MonsterPiece) -> void:
	pass

#-------------------------------------------------------------------------------
# parent functions
#-------------------------------------------------------------------------------
func update_piece_position(piece: MonsterPiece, new_position: Vector2) -> void:
	piece.drop_point_detector.position = new_position
	piece.drop_point_collision_shape.position = new_position
	piece.piece_detector.position = new_position
	#for child in piece.piece_detector.get_children():
			#child.position = new_position
	piece.setPosition( new_position )


#-------------------------------------------------------------------------------
# class functions
#-------------------------------------------------------------------------------
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
