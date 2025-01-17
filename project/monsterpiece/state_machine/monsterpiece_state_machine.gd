class_name MonsterPieceStateMachine
extends Node

@export var initial_state: MonsterPieceState

var current_state: MonsterPieceState
var states: Dictionary = {}

func _ready():
	#print("\t\t\t\t\tMP state machine for %s" % get_parent().name)
	for child in get_children():
		if child is MonsterPieceState:
			#print("\t\t\t\t\t\tstate %s" % child.name.to_lower())
			states[child.name.to_lower()] = child
			child.transitioned.connect(on_child_transition)
			#var script_name = "res://monsterpiece/state_machine/states/%s_card_state.gd" % child.name.to_lower() 
			var script_name = child.get_script()
			#print ("\t\t\t\t\t\t\t script= %s" % script_name)
			#child.monsterpiece.set_script( script_name )
			if child.get_children():
				for sub_child in child.get_children():
					states[child.name.to_lower() + '/' + sub_child.name.to_lower()] = sub_child
					sub_child.transitioned.connect(on_child_transition)
	#print(states)
	
	if initial_state:
		initial_state.call_deferred("_enter")
		current_state = initial_state


func on_input(event: InputEvent):
	if current_state:
		#print("MP on_input = %s" % current_state.name.to_lower())
		current_state.on_input(event)


func on_gui_input(event: InputEvent):
	if current_state:
		current_state.on_gui_input(event)


func on_mouse_entered():
	if current_state:
		current_state.on_mouse_entered()


func on_mouse_exited():
	if current_state:
		current_state.on_mouse_exited()


func on_child_transition(new_state_name):
	var new_state: MonsterPieceState = states.get(new_state_name.to_lower())
	if !new_state:
		prints(current_state, "MP transition to no state")
		return
	
	if current_state:
		current_state._exit()
		
	new_state.call_deferred("_enter")
	
	current_state = new_state
	
	prints(get_parent() ,"MP urrent state", current_state)
