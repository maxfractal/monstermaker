#===============================================================================
# class: Library
#
#	all of the (unused) pieces available for a monster
#
# TODO
# - handle loading of another set of pieces, like unloading current set
# - handle drag-n-drop: taking out a piece and putting one back
#===============================================================================
#@icon("ref://icons/H_SUMO.svg")
#@icon("ref:///icons/H_SAMURAI.svg")
#@icon("ref:///icons/shambling-mound.svg")
#@icon("ref:///icons/B_DOBUTSUEN.png")
class_name Library extends PieceField
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
@onready var pieces_scroller: ScrollContainer = $MarginContainer/PartsScrollContainer
@onready var pieces_holder: VBoxContainer = $MarginContainer/PartsScrollContainer/PartsContainer
@onready var piece_drop: Area2D = $LibraryPartDrop
@onready var file_dialog: FileDialog = $LoadLibraryButton/LibraryFolderSelectDialog
@onready var load_button: Button = $LoadLibraryButton

var folder_path = "res://art/Creatures/Skeleton/"  # Replace with your folder path

#-------------------------------------------------------------------------------
# preloads
#-------------------------------------------------------------------------------
# load the monster piece scene ONCE so it can be instantiated when loading the library
var new_piece_scene = preload("res://project/monsterpiece/monster_piece.tscn")

#-------------------------------------------------------------------------------
# class functions
#-------------------------------------------------------------------------------
# Called when the node enters the scene tree for the first time.
#
func _ready() -> void:
	print("Library ready")
	#$LibraryTitle.text = name

	# hook up signals so the library can load a set of pieces when a folder
	# has been picked from the file dialog 	
	#
	file_dialog.connect("dir_selected", Callable(self, "_on_folder_selected"))
	file_dialog.connect("canceled", Callable(self, "_on_dialog_canceled"))
	return

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# main function to load a folder of pieces into the library.
#
func load_Library():
	print("Start loading library")
	print("\tLibrary folder path:", folder_path)
	
	
	print("library   z-index: %s" % str(self.z_index))
	print("lib hldr  z-index: %s" % str(self.pieces_holder.z_index))
	print("drop area z-index: %s" % str(get_node("/root/Game/Monster Section").z_index))
	#print("libr area: %s" % str(piece_drop.z_index))
	
	#	open the folder and traverse the files, loading all of the images
	#
	var dir = DirAccess.open(folder_path)
	dir.list_dir_begin()
	print("\t\tDirectory: (%s)" % folder_path)
	if dir:
		print("\t\t directory found.")
		var file_name = dir.get_next()
		while file_name != "":
			if !dir.current_is_dir() and file_name.ends_with(".png"):
				var file_path = folder_path + file_name
				print("\t\t\treading %s" % file_path)
				
				# load the image, instantiate a piece and attach the image to it
				generate_piece(file_path)
			file_name = dir.get_next()
	
	# after the pieces are all created, see if the scroll bar needs to be visible or not
	#pieces_scroller.scroll_vertical = ScrollContainer.ScrollMode.SCROLL_MODE_AUTO
	#pieces_holder.add_theme_constant_override("separation", (LIBRARY_TILE_HEIGHT_MAX + LIBRARY_TILE_GAP) )

	# DEBUG
	#   see what children the vbox has
	print("\n\t<-- library piece list -->")
	var i = 0
	for child in pieces_holder.get_children():
		i=i+1
		#print("\t piece %d" %i, " = %s" %child.name + "  \tpos=%s" % str(child.get_screen_position()))
		#print("\t piece %d" %i, " = %s" %child.name + "  \tZ=%s" % str(child.z_index) + " \tZ relative=%s" % str(child.z_relative))
	print("\t<-- END of library piece list -->\n")
	print("End loading library")
	return
	
#	generate_piece will
#		- load the image (texture)
#		- upon success, instatiate a new piece
#		- attach the image to the piece
#		- add the piece to the piece container
#
func generate_piece(file_path):
	var loadedTexture = load(file_path)
	if loadedTexture == null:
		print("ERROR: Failed to load texture from path:", file_path)
		return false

	# create a new MonsterPiece, configure it then add it to the container
	var new_part : MonsterPiece = new_piece_scene.instantiate()
	new_part.state_machine = MonsterPieceStateMachine.new()
	
	# NOTE: MUST add piece to the hierarchy FIRST so it instantiates all of the children nodes
	# of MonsterPiece!
	#
	#print("\t\t\t\tpiece %s" %new_part.state_machine)
	pieces_holder.add_child(new_part)
	#print("\t\t\t\tpiece added %s" %new_part.name + " - container size = %d" % pieces_holder.get_child_count())

	#  set the size + position after adding to parent
	new_part.position = Vector2(0,0)
	new_part.size = Vector2(50,50)
	new_part.home_field = self			# set the "parent" of drop to this library
	
	# fill in the textureRect, set the new texture, then add it to the new piece
	new_part.icon_texture_rect.texture = loadedTexture
	#new_part.icon_texture_rect.visible = false
	#new_part.icon_texture_rect.visible = not new_part.icon_texture_rect.visible
	new_part.piece_texture_rect.texture = loadedTexture
	new_part.piece_texture_rect.set_position(Vector2(0,0))

	# set part + texture variables	
	#new_part.y_sort_enabled = true
	#new_part.z_index = 10
	#new_part.piece_texture_rect.z_index = 20
	#new_part.icon_texture_rect.texture.y_sort_enabled = true

	# set up the collision shape
	var rect = CollisionShape2D.new()
	new_part.piece_detector.add_child(rect)
	
	var the_shape = RectangleShape2D.new()
	rect.shape = the_shape
	rect.position = Vector2(0,0)
	new_part.collision_shape = rect
	
	#the_shape.extents = Vector2(51, 51)
	the_shape.set_size(Vector2(50,50))
	#the_shape.size = Vector2(50, 50)

	print("\t\t\t\t\tpiece z    " + str(new_part.z_index))
	print("\t\t\t\t\tpiece spos " + str(new_part.get_screen_position()))
	print("\t\t\t\t\tpiece rect " + str(new_part.get_rect()))
	print("\t\t\t\t\tpiece globl" + str(new_part.get_global_rect()))
	print("\t\t\t\t\ttexture pos" + str(new_part.piece_texture_rect.get_position()))
	print("\t\t\t\t\ttexture siz" + str(new_part.piece_texture_rect.get_size()))
	print("\t\t\t\t\ttexture off" + str(new_part.piece_texture_rect.get_pivot_offset()))
	#print("\t\t\t\t\tdtector pos" + str(new_part.piece_detector.position))
	#print("\t\t\t\t\trect   pos " + str(rect.position))
	#print("\t\t\t\t\tshape size " + str(rect.shape.size))
	#print("\t\t\t\t\tshape extnt" + str(rect.shape.extents))
	#rect.disabled = false
	#new_part.piece_detector.set_pickable(true)
	#print("new piece created: detector %s" %new_part.piece_detector)
	#print("new piece created: collider %s" %new_part.collision_shape)
	#print("                            %s" %new_part.piece_detector.position)
	
	#piece_detector := $MPDetector
	#collision_shape:= $MPCollisionShape2D
	#new_part.piece_texture_rect.expand = true
	#new_part.piece_texture_rect.expand_mode = TextureRect.EXPAND_FIT_WIDTH_PROPORTIONAL
	#new_part.piece_texture_rect.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT
	#var newSize = scale_texture(new_part.piece_texture_rect)
	#new_part.piece_texture_rect.set_size( newSize )
	#new_part.piece_texture_rect.set_position( Vector2(0,1) )
	
	#print("\t\t\t\t new size (%d" % newSize.x + ",%4d" % newSize.y + ")")
	return
	
#	scale_texture will resize the TextureRect so the image fits in the piece
#	container while maintaining it's aspect ratio
#
func scale_texture(piece_texture_rect):
	if piece_texture_rect.texture:
		var texture_size = piece_texture_rect.texture.get_size()
		var aspect_ratio
		var new_width
		var new_height
		
		#	figure out which dimension is larger so the thumbnail is as large
		#	as it can be
		#print("--------old size (%d" % texture_size.x + ",%4d" % texture_size.y + ")")
		if texture_size.x > texture_size.y:
			aspect_ratio = texture_size.y / texture_size.x
			new_width = min(LIBRARY_TILE_WIDTH_MAX, texture_size.x)
			new_height = new_width * aspect_ratio
		else:
			aspect_ratio = texture_size.x / texture_size.y
			new_height = min(LIBRARY_TILE_WIDTH_MAX, texture_size.y)
			new_width = new_height * aspect_ratio
		#print("--------new size (%d" % new_width + ",%4d" % new_height + ")")
		return Vector2(new_width, new_height)
	return Vector2(1,1)

func return_part_starting_position(part: MonsterPiece):
	part.reparent(pieces_holder)
	pieces_holder.move_child(part, part.index)


func set_new_part(part: MonsterPiece):
	part_reposition(part)
	part.home_field = self


func part_reposition(part: MonsterPiece):
	print("PART REPOSITION!")
	var field_areas = part.piece_detector.get_overlapping_areas()
	var parts_areas = part.part_detector.get_overlapping_areas()
	var index: int = 0
	
	if parts_areas.is_empty():
		print(field_areas.has(piece_drop))
		if field_areas.has(piece_drop):
			index = pieces_holder.get_children().size()
	elif parts_areas.size() == 1:
		if field_areas.has(piece_drop):
			index = parts_areas[0].get_parent().get_index()
		else:
			index = parts_areas[0].get_parent().get_index() + 1
	else:
		index = parts_areas[0].get_parent().get_index()
		if index > parts_areas[1].get_parent().get_index():
			index = parts_areas[1].get_parent().get_index()
		
		index += 1

	part.reparent(pieces_holder)
	pieces_holder.move_child(part, index)
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
	return

# FILEDIALOG signal - handle file dialog cancel
func _on_dialog_canceled():
	# Perform actions when the dialog is canceled
	print("Library Folder Dialog was canceled")

	# if the dialog is CANCELLED then put a hard-coded value in
	# this is for DEBUG ONLY
	if (DEBUG_MODE):
		folder_path = "res://art/Creatures/Pirate/"
		#folder_path = "res://art/Creatures/Villager/"
		load_Library()
	return

#-------------------------------------------------------------------------------
# code snippet graveyard
#-------------------------------------------------------------------------------

	
#	are there enough pieces to need the scrollbar visible?
#
#func check_for_scroll(scroll_container : ScrollContainer, vbox_container):
	##if vbox_container.get_child_count() > NUM_PIECES_TO_ACTIVATE_SCROLLBAR:
		##scroll_container.scroll_vertical_enabled = true
	##else:
		##scroll_container.scroll_vertical_enabled = false
	#return;
	
	##start debug info -----------------------------------------------
	#print("-Folder path:", folder_path)
#
	#var scroll_container = get_node("PartsScrollContainer")
	#if scroll_container == null:
		#print("PartsScrollContainer node not found")
		#return
	#pieces_holder = scroll_container.get_node("PartsContainer")
	#if pieces_holder == null:
		#print("PartsContainer node not found")
		#return
	##end debug info -------------------------------------------------
	#
	## hook up the pre-made parts to the parent PartsHolder
	##for child in pieces_holder.get_children():
		##print("part %s" %child.name)
		##var part := child as Part
		##part.home_field = self
