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
@onready var collision_shape:= $MPDetector/MPCollisionShape2D
@onready var piece_texture_rect := $MPTextureRect
@onready var icon_texture_rect := $MPTextureRect
@onready var home_field: MarginContainer
@onready var drop_point_detector := $DropPointDetector

var index: int = 0
var count = 0

#-------------------------------------------------------------------------------
# class functions
#-------------------------------------------------------------------------------
func setPosition(newPosition):
	self.position = newPosition
	piece_texture_rect.position = newPosition
	$MPColorRect.position = newPosition
	$MPNameLabel.position = newPosition
	$MPLabel.position = newPosition
	drop_point_detector.position = newPosition
	collision_shape.position = newPosition
	piece_detector.position = newPosition
	$DropPointDetector/CollisionShape2D.position = newPosition
	return
	
#-------------------------------------------------------------------------------
# built-in functions
#-------------------------------------------------------------------------------
func _ready():
	#print("monsterpiece ready start - %s" %name)
	name_label.text = " "
	#print("monsterpiece _ready----------------")
	#print ("\t states= %s" % state_machine.states)
	#print("monsterpiece ----------------------")
	return
	
func _input(event):
	state_machine.on_input(event)

	if event.is_action_pressed("mouse_left"):
		print("mouse click at: %s " % event.position)

#	if event is InputEventMouseButton:
		#if event.pressed:
			#count += 1
			#print("Click:" + str(count))
	return
	
func _on_gui_input(event):
	state_machine.on_gui_input(event)

func _on_mouse_entered():
	state_machine.on_mouse_entered()

func _on_mouse_exited():
	state_machine.on_mouse_exited()
