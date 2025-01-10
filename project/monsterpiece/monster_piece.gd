class_name MonsterPiece extends Control

@onready var color_rect: ColorRect = $ColorRect
@onready var label: Label = $Label
@onready var name_label: Label = $NameLabel
@onready var state_machine: MonsterPieceStateMachine = $MonsterPieceStateMachine
@onready var piece_detector: Area2D = $PieceDetector
@onready var home_field: MarginContainer
@onready var texture_rect: TextureRect

var index: int = 0

func _ready():
	print("monsterpiece ready start - %s" %name)
	
	name_label.text = name
	#return
	print("monsterpiece ready end - %s" %name)

func _input(event):
	state_machine.on_input(event)

func _on_gui_input(event):
	state_machine.on_gui_input(event)

func _on_mouse_entered():
	state_machine.on_mouse_entered()

func _on_mouse_exited():
	state_machine.on_mouse_exited()
