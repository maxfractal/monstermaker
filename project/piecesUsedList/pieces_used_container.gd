#===============================================================================
# class: PiecesUsedContainer
#
#	all of the (used) pieces currently being used for a monster
#
# TODO
# - 
# - 
#===============================================================================
@icon("ref:///icons/B_DOBUTSUEN.png")
class_name PiecesUsedContainer extends MarginContainer

#-------------------------------------------------------------------------------
# constants
#-------------------------------------------------------------------------------
const PIECESUSED_TILE_WIDTH_MAX = 100 
const PIECESUSED_TILE_HEIGHT_MAX = 100
const PIECESUSED_TILE_GAP = 10
const DEBUG_MODE = true;
const NUM_PIECES_TO_ACTIVATE_SCROLLBAR = 8

#-------------------------------------------------------------------------------
# variables
#-------------------------------------------------------------------------------
@onready var pieces_scroller: ScrollContainer = $PiecesMarginContainer/PiecesScrollContainer
@onready var pieces_holder: VBoxContainer = $PiecesMarginContainer/PiecesScrollContainer/PiecesUsedList



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Pieces Used List ready")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
