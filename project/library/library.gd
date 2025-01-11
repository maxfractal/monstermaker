#===============================================================================
# class: Library
#
#	all of the (unused) pieces available for a monster
#
# TODO
# - handle loading of another set of pieces, like unloading current set
# - handle drag-n-drop: taking out a piece and putting one back
#===============================================================================
class_name Library extends MarginContainer
#extends Field

#-------------------------------------------------------------------------------
# constants
#-------------------------------------------------------------------------------
const LIBRARY_TILE_WIDTH_MAX = 100 
const LIBRARY_TILE_HEIGHT_MAX = 100
const LIBRARY_TILE_GAP = 10
const DEBUG_MODE = true;
const NUM_PIECES_TO_ACTIVATE_SCROLLBAR = 6

#-------------------------------------------------------------------------------
# variables
#-------------------------------------------------------------------------------
@onready var parts_holder: VBoxContainer = $PartsScrollContainer/PartsContainer
@onready var part_drop: Area2D = $LibraryPartDrop
@onready var file_dialog: FileDialog = $LoadLibraryButton/LibraryFolderSelectDialog
@onready var load_button: Button = $LoadLibraryButton

var folder_path = "res://art/Creatures/Pirate/"  # Replace with your folder path
#var folder_path = "res://art/Creatures/Skeleton/"  # Replace with your folder path

#-------------------------------------------------------------------------------
# preloads
#-------------------------------------------------------------------------------
# load the monster piece scene ONCE so it can be instantiated when loading the library
var new_piece_scene = preload("res://project/monsterpiece/monster_piece.tscn")


# Called when the node enters the scene tree for the first time.
#
func _ready() -> void:
	print("Library ready start")
	$LibraryTitle.text = name

	# hook up signals so the library can load a set of pieces when a folder
	# has been picked from the file dialog 	
	#
	file_dialog.connect("dir_selected", Callable(self, "_on_folder_selected"))
	file_dialog.connect("canceled", Callable(self, "_on_dialog_canceled"))

	##start debug info -----------------------------------------------
	#print("-Folder path:", folder_path)
#
	#var scroll_container = get_node("PartsScrollContainer")
	#if scroll_container == null:
		#print("PartsScrollContainer node not found")
		#return
	#parts_holder = scroll_container.get_node("PartsContainer")
	#if parts_holder == null:
		#print("PartsContainer node not found")
		#return
	##end debug info -------------------------------------------------
	#
	## hook up the pre-made parts to the parent PartsHolder
	##for child in parts_holder.get_children():
		##print("part %s" %child.name)
		##var part := child as Part
		##part.home_field = self
	return

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# main function to load a folder of pieces into the library.
#
func load_Library():
	print("--Start loading library")
	print("---Folder path:", folder_path)
	
	# go through the children nodes and get a pointer to the 
	# container that will hold the instances of the pieces
	#
	var scroll_container : ScrollContainer = get_node("PartsScrollContainer")
	if scroll_container == null:
		print("PartsScrollContainer node not found")
		return
	var the_parts_holder : VBoxContainer = scroll_container.get_node("PartsContainer")
	if the_parts_holder == null:
		print("PartsContainer node not found")
		return
	
	#	open the folder and traverse the files, loading all of the images
	#
	var dir = DirAccess.open(folder_path)
	dir.list_dir_begin()
	print("---Directory: (%s)" % folder_path)
	if dir:
		print("----directory found.")
		var file_name = dir.get_next()
		while file_name != "":
			if !dir.current_is_dir() and file_name.ends_with(".png"):
				var file_path = folder_path + file_name
				print("-----reading %s" % file_path)
				
				# load the image, instantiate a piece and attach the image to it
				generate_piece(file_path, parts_holder)
			file_name = dir.get_next()
	
	# after the pieces are all created, see if the scroll bar needs to be visible or not
	scroll_container.scroll_vertical = ScrollContainer.ScrollMode.SCROLL_MODE_AUTO
	#check_for_scroll(scroll_container, the_parts_holder)
	the_parts_holder.add_theme_constant_override("separation", (LIBRARY_TILE_HEIGHT_MAX + LIBRARY_TILE_GAP) )
	
	print("--End loading library")

#	generate_piece will
#		- load the image (texture)
#		- upon success, instatiate a new piece
#		- attach the image to the piece
#		- add the piece to the piece container
#
func generate_piece(file_path, the_parts_holder):
	var loadedTexture = load(file_path)
	if loadedTexture == null:
		print("ERROR: Failed to load texture from path:", file_path)
		return false

	var new_part : MonsterPiece = new_piece_scene.instantiate()
	the_parts_holder.add_child(new_part)

	var new_texturerect = TextureRect.new()
	new_texturerect.texture = loadedTexture
	scale_texture(new_texturerect)
	new_part.texture_rect = new_texturerect
	return
	
#	scale_texture will resize the TextureRect so the image fits in the piece
#	container while maintaining it's aspect ratio
#
func scale_texture(texture_rect):
	if texture_rect.texture:
		var texture_size = texture_rect.texture.get_size()
		var aspect_ratio
		var new_width
		var new_height
		print("--------old size (%d" % texture_size.x + ",%4d" % texture_size.y + ")")
		
		#	figure out which dimension is larger so the thumbnail is as large
		#	as it can be
		if texture_size.x > texture_size.y:
			aspect_ratio = texture_size.y / texture_size.x
			new_width = min(LIBRARY_TILE_WIDTH_MAX, texture_size.x)
			new_height = new_width * aspect_ratio
		else:
			aspect_ratio = texture_size.x / texture_size.y
			new_height = min(LIBRARY_TILE_WIDTH_MAX, texture_size.y)
			new_width = new_height * aspect_ratio
		print("--------new size (%d" % new_width + ",%4d" % new_height + ")")
		
		# set a bunch of TextureRect parameters
		texture_rect.set_size(Vector2(new_width, new_height))
		texture_rect.expand = true;
		texture_rect.expand_mode = TextureRect.EXPAND_FIT_HEIGHT_PROPORTIONAL
		texture_rect.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT

#	are there enough pieces to need the scrollbar visible?
#
func check_for_scroll(scroll_container : ScrollContainer, vbox_container):
	#if vbox_container.get_child_count() > NUM_PIECES_TO_ACTIVATE_SCROLLBAR:
		#scroll_container.scroll_vertical_enabled = true
	#else:
		#scroll_container.scroll_vertical_enabled = false
	return;
	
func return_part_starting_position(part: MonsterPiece):
	part.reparent(parts_holder)
	parts_holder.move_child(part, part.index)


func set_new_part(part: MonsterPiece):
	part_reposition(part)
	part.home_field = self


func part_reposition(part: MonsterPiece):
	#var field_areas = part.drop_point_detector.get_overlapping_areas()
	#var parts_areas = part.part_detector.get_overlapping_areas()
	#var index: int = 0
	#
	#if parts_areas.is_empty():
		#print(field_areas.has(part_drop_area_left))
		#if field_areas.has(part_drop_area_right):
			#index = parts_holder.get_children().size()
	#elif parts_areas.size() == 1:
		#if field_areas.has(part_drop_area_left):
			#index = parts_areas[0].get_parent().get_index()
		#else:
			#index = parts_areas[0].get_parent().get_index() + 1
	#else:
		#index = parts_areas[0].get_parent().get_index()
		#if index > parts_areas[1].get_parent().get_index():
			#index = parts_areas[1].get_parent().get_index()
		#
		#index += 1
#
	#part.reparent(parts_holder)
	#parts_holder.move_child(part, index)
	return;

#-------------------------------------------------------------------------------
#	Signal functions
#-------------------------------------------------------------------------------

# FILEDIALOG signal - handle folder selection
func _on_folder_selected(selected_folder_path):
	# Perform actions with the selected folder path
	print("Folder dialog returned path: ", selected_folder_path)
	folder_path = selected_folder_path + "/"

	load_Library()

# FILEDIALOG signal - handle file dialog cancel
func _on_dialog_canceled():
	# Perform actions when the dialog is canceled
	print("Library Folder Dialog was canceled")

	# if the dialog is CANCELLED then put a hard-coded value in
	# this is for DEBUG ONLY
	if (DEBUG_MODE):
		folder_path = "res://art/Creatures/Pirate/"
		load_Library()
