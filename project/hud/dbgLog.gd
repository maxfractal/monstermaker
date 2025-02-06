extends Control

var debug: bool = OS.has_feature("debug")

@onready var dbgCanvasLayer: CanvasLayer = CanvasLayer.new()
@onready var dbgPanel: Panel = Panel.new()
@onready var dbgPanelRT: Panel = Panel.new()
@onready var dbgLabel: RichTextLabel = RichTextLabel.new()
@onready var dbgLabelRT: RichTextLabel = RichTextLabel.new()
# @onready var theme: Theme = load("res://SurvivalScape.theme") # Your custom theme file

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS

	if debug:
		if OS.get_name() == "Android" or OS.get_name() == "iOS":
			pass
		else:
			dbgCanvasLayer.layer = 128
			add_child(dbgCanvasLayer)
			
			dbgPanel.size = Vector2(273, 600)
			dbgPanel.position = Vector2(800,0)
			dbgPanel.set_anchors_preset(Control.PRESET_TOP_LEFT, true)
			dbgPanel.self_modulate = Color("214f0c")
			dbgPanel.mouse_filter = Control.MOUSE_FILTER_IGNORE
			dbgCanvasLayer.add_child(dbgPanel)

			dbgLabel.text = ""
			dbgLabel.set_anchors_preset(Control.PRESET_FULL_RECT)
			dbgLabel.scroll_following = true
			dbgLabel.push_font_size(12)
			dbgPanel.add_child(dbgLabel)

			dbgPanelRT.size = Vector2(273, 50)
			dbgPanelRT.position = Vector2(800,602)
			dbgPanelRT.set_anchors_preset(Control.PRESET_TOP_LEFT, true)
			dbgPanelRT.self_modulate = Color("214f0c")
			dbgPanelRT.mouse_filter = Control.MOUSE_FILTER_IGNORE
			dbgCanvasLayer.add_child(dbgPanelRT)

			dbgLabelRT.text = ""
			dbgLabelRT.set_anchors_preset(Control.PRESET_FULL_RECT)
			dbgLabelRT.scroll_following = false
			dbgLabelRT.push_font_size(10)
			dbgPanelRT.add_child(dbgLabelRT)
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("toggle_console"):
		if self.visible:
			self.visible = false
		else:
			self.visible = true


func print(msg1: String, msg2 = null, msg3 = null, msg4 = null, msg5 = null, msg6 = null) -> void:
	var s: String = msg1 + "\n"			# string for dbg window (needs extra CRs)
	var sc: String = msg1				# string for console
	if (msg2 != null):
		s += str(msg2) + "\n"
		sc += str(msg2)
	if (msg3 != null):
		s += str(msg3) + "\n"
		sc += str(msg3)
	if (msg4 != null):
		s += str(msg4) + "\n"
		sc += str(msg4)
	if (msg5 != null):
		s += str(msg5) + "\n"
		sc += str(msg5)
	if (msg6 != null):
		s += str(msg6) + "\n"
		sc += str(msg6)
	if dbgLabel:
		dbgLabel.append_text(s)
	print(sc)

func printRT(msg1: String, msg2 = null, msg3 = null, msg4 = null, msg5 = null, msg6 = null) -> void:
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
		dbgLabelRT.set_text(s)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
