extends FileDialog

# Define custom signals
signal folder_selected(folder_path)
signal dialog_canceled

# Connect the folder selected signal to the function
func _ready():
	connect("dir_selected", Callable(self, "_on_file_selected"))
	connect("popup_hide", Callable(self, "_on_dialog_canceled"))

# Function to handle folder selection
func _on_file_selected(path):
	# Emit the custom signal with the selected folder path
	emit_signal("folder_selected", path)
	print("Selected folder path: ", path)

# Function to handle dialog cancellation
func _on_dialog_canceled():
	# Emit the custom dialog_canceled signal
	emit_signal("dialog_canceled")
	print("Cancelled folder path: ")


# Function to load images from the selected folder
func load_images_from_folder(folder_path):
	var dir = DirAccess.open(folder_path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir() == false:
				var file_path = folder_path.plus_file(file_name)
				# Load the image file
				var img = Image.new()
				var error = img.load(file_path)
				if error == OK:
					# Do something with the image (e.g., add it to a texture or sprite)
					var texture = ImageTexture.new()
					texture.create_from_image(img)
					# Example: Print the file path
					print(file_path)
			file_name = dir.get_next()
		dir.list_dir_end()
