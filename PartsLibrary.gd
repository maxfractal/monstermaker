class_name PartsLibrary
extends Node2D

var folder_path = "res://art/Creatures/Pirate/"  # Replace with your folder path
var library_max_tile_width = 200 

func _ready():
	print("Start loading library")
	print("  Folder path:", folder_path)
	
	var canvas_layer = get_node("CanvasLayer")
	if canvas_layer == null:
		print("CanvasLayer node not found")
		return

	print("  Children of canvas layer node:")
	for child in canvas_layer.get_children():
		print("   %s" % child.name)

	var scroll_container = canvas_layer.get_node("ScrollContainer-Library")
	if scroll_container == null:
		print("ScrollContainer node not found")
		return
	var vbox_container = scroll_container.get_node("VBoxContainer-Library")
	if vbox_container == null:
		print("VBoxContainer node not found")
		return
	
	load_images_from_folder( scroll_container, vbox_container )
	#check_for_scroll(scroll_container, vbox_container)

func load_images_from_folder( scroll_container, vbox_container ):
	var dir = DirAccess.open(folder_path)
	dir.list_dir_begin()
	print("Directory: (%s)" % folder_path)
	if dir:
		print("  directory found.")
		var file_name = dir.get_next()
		while file_name != "":
			if !dir.current_is_dir() and file_name.ends_with(".png"):
				var file_path = folder_path + file_name
				print("     - reading %s" % file_path)
				display_image(file_path, scroll_container, vbox_container)
			file_name = dir.get_next()

func display_image(file_path, scroll_container, vbox_container):
	var texture = load(file_path)
	if texture == null:
		print("ERROR: Failed to load texture from path:", file_path)
		return false
	print("        texture loaded: %s" % file_path)
	var texture_rect = TextureRect.new()
	texture_rect.texture = texture
	
	scale_texture(texture_rect)
	
	vbox_container.add_child(texture_rect)

func scale_texture(texture_rect):
	if texture_rect.texture:
		var texture_size = texture_rect.texture.get_size()
		print("          old size (%d" % texture_size.x + ",%4d" % texture_size.y + ")")
		var aspect_ratio = texture_size.y / texture_size.x
		var new_width = min(library_max_tile_width, texture_size.x)
		var new_height = new_width * aspect_ratio
		#texture_rect.texture.rect_size = Vector2(new_width, new_height)
		print("          new size (%d" % new_width + ",%4d" % new_height + ")")
		#texture_rect.set_size(Vector2(new_width, new_height))
		texture_rect.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT
		#texture_rect.expand = TextureRect.EXPAND_FIT_WIDTH
		
func check_for_scroll(scroll_container, vbox_container):
	if vbox_container.get_child_count() > 10:
		scroll_container.scroll_vertical_enabled = true
	else:
		scroll_container.scroll_vertical_enabled = false