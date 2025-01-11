#===============================================================================
# class: MonsterPiece
#
#	represents a single image or piece of a monster
#===============================================================================
class_name MonsterPiece extends Control

#-------------------------------------------------------------------------------
# variables
#-------------------------------------------------------------------------------
@onready var color_rect := $MPColorRect
@onready var label := $MPLabel
@onready var name_label := $MPNameLabel
@onready var state_machine := $MonsterPieceStateMachine
@onready var piece_detector := $MPDetector
@onready var texture_rect := $MPTextureRect
@onready var home_field: MarginContainer

var index: int = 0

#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------
func _ready():
	#print("monsterpiece ready start - %s" %name)
	name_label.text = " "

func _input(event):
	state_machine.on_input(event)

func _on_gui_input(event):
	state_machine.on_gui_input(event)

func _on_mouse_entered():
	state_machine.on_mouse_entered()

func _on_mouse_exited():
	state_machine.on_mouse_exited()
