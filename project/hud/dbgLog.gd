extends Control

var debug: bool = OS.has_feature("debug")

@onready var panel: Panel = Panel.new()
@onready var canvas_layer: CanvasLayer = CanvasLayer.new()
@onready var dbgLabel: RichTextLabel = RichTextLabel.new()
# @onready var theme: Theme = load("res://SurvivalScape.theme") # Your custom theme file

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS

	if debug:
		if OS.get_name() == "Android" or OS.get_name() == "iOS":
			pass
		else:
			canvas_layer.layer = 128
			panel.size = Vector2(273, 646)
			panel.position = Vector2(800,0)
			# panel.theme = theme
			panel.set_anchors_preset(Control.PRESET_TOP_LEFT, true)
			#panel.self_modulate = Color(101,85,31,1.0)
			panel.self_modulate = Color("214f0c")

			dbgLabel.text = ""
			# dbgLabel.theme = theme
			dbgLabel.set_anchors_preset(Control.PRESET_FULL_RECT)
			dbgLabel.scroll_following = true
			dbgLabel.push_font_size(12)
			panel.add_child(dbgLabel)

			canvas_layer.add_child(panel)
			add_child(canvas_layer)
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("toggle_console"):
		if self.visible:
			self.visible = false
		else:
			self.visible = true


func print(msg1: String, msg2 = null, msg3 = null, msg4 = null, msg5 = null, msg6 = null) -> void:
	var s: String = msg1 + "\n"
	if (msg2 != null):
		s += str(msg2) + "\n"
	if (msg3 != null):
		s += str(msg3) + "\n"
	if (msg4 != null):
		s += str(msg4) + "\n"
	if (msg5 != null):
		s += str(msg5) + "\n"
	if (msg6 != null):
		s += str(msg6) + "\n"
	if dbgLabel:
		dbgLabel.append_text(s)

	print(s)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
