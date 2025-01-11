extends Button

# Reference to the FileDialog node
@onready var file_dialog = $LibraryFolderSelectDialog

# Function to handle button press
func _on_button_pressed():
	file_dialog.popup_centered()  # Open the FileDialog

# Connect the button's pressed signal to the function
func _ready():
	connect("pressed", Callable(self, "_on_button_pressed"))
	return
