extends FileDialog

# Connect the folder selected signal to the function
func _ready():
	return
	
# Function to handle folder selection
func _on_file_selected(path):
	# Emit the custom signal with the selected folder path
	#print("Selected folder path: ", path)
	return
# Function to handle dialog cancellation
func _on_dialog_canceled():
	# Emit the custom dialog_canceled signal
	#print("Cancelled folder path: ")
	return
