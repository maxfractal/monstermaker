class_name Part
extends Control

@onready var color_rect: ColorRect = $ColorRect
@onready var label: Label = $Label
@onready var name_label: Label = %NameLabel
@onready var state_machine: PartStateMachine = $PartStateMachine
@onready var drop_point_detector: Area2D = $DropPointDetector
@onready var part_detector: Area2D = $PartsDetector
@onready var home_field: MarginContainer
@onready var texture_rect: TextureRect

var index: int = 0

func _ready():
	print("part ready start")
	print ("  %s" %name)
	name_label.text = name

func _input(event):
	state_machine.on_input(event)

func _on_gui_input(event):
	state_machine.on_gui_input(event)

func _on_mouse_entered():
	state_machine.on_mouse_entered()

func _on_mouse_exited():
	state_machine.on_mouse_exited()
