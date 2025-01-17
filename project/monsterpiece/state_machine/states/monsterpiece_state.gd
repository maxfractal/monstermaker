#===============================================================================
# class: Library
#
#	all of the (unused) pieces available for a monster
#
# TODO
# - handle loading of another set of pieces, like unloading current set
# - handle drag-n-drop: taking out a piece and putting one back
#===============================================================================
class_name MonsterPieceState
extends Node

#-------------------------------------------------------------------------------
# signal
#-------------------------------------------------------------------------------
signal transitioned

#-------------------------------------------------------------------------------
# variables
#-------------------------------------------------------------------------------
@export var monsterpiece: MonsterPiece


func _enter():
	pass


func _exit():
	pass


func on_input(_event: InputEvent):
	pass


func on_gui_input(_event: InputEvent):
	pass


func on_mouse_entered():
	pass


func on_mouse_exited():
	pass
