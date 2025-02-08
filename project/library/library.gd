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

#-------------------------------------------------------------------------------
# Library loadings and piece creation
#-------------------------------------------------------------------------------

# main function to load a folder of pieces into the library.
#
func load_Library():
	print("Start loading library")
	print("\tLibrary folder path:", folder_path)

	#print("library   z-index: %s" % str(self.z_index))
	#print("lib hldr  z-index: %s" % str(self.pieces_holder.z_index))
	#print("drop area z-index: %s" % str(get_node("/root/Game/Monster Section").z_index))
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
				generate_piece(pieces_holder, file_path)
			file_name = dir.get_next()

	# after the pieces are all created, see if the scroll bar needs to be visible or not
	#pieces_scroller.scroll_vertical = ScrollContainer.ScrollMode.SCROLL_MODE_AUTO
	#pieces_holder.add_theme_constant_override("separation", (LIBRARY_TILE_HEIGHT_MAX + LIBRARY_TILE_GAP) )

	# DEBUG
	#   see what children the vbox has
	#print("\n\t<-- library piece list -->")
	#var i = 0
	#for child in pieces_holder.get_children():
		#i=i+1
		##print("\t piece %d" %i, " = %s" %child.name + "  \tpos=%s" % str(child.get_screen_position()))
		##print("\t piece %d" %i, " = %s" %child.name + "  \tZ=%s" % str(child.z_index) + " \tZ relative=%s" % str(child.z_relative))
	#print("\t<-- END of library piece list -->\n")
	#print("End loading library\n\n")
	dbgLog.print("End loading library\n\n")
	return

#-------------------------------------------------------------------------------
# piece dragging + dropping
#-------------------------------------------------------------------------------

func return_monsterpiece_starting_position(piece: MonsterPiece):
	piece.reparent(pieces_holder)
	
	var new_position = Vector2(0,0)
	update_piece_position( piece, new_position )	
	print("return piece starting position (library) %s " % piece.index)


func set_new_monsterpiece(piece: MonsterPiece):
	monsterpiece_reposition(piece)
	piece.home_field = self


func monsterpiece_reposition(piece: MonsterPiece):
	dbgLog.print("-------------PART REPOSITION (library)")
	var field_areas = piece.drop_point_detector.get_overlapping_areas()
	var pieces_areas = piece.piece_detector.get_overlapping_areas()
	var index: int = 0
	
	if pieces_areas.is_empty():
		print(field_areas.has(piece_drop))
		if field_areas.has(piece_drop):
			index = pieces_holder.get_children().size()
	elif pieces_areas.size() == 1:
		if field_areas.has(piece_drop):
			index = pieces_areas[0].get_parent().get_index()
		else:
			index = pieces_areas[0].get_parent().get_index() + 1
	else:
		index = pieces_areas[0].get_parent().get_index()
		if index > pieces_areas[1].get_parent().get_index():
			index = pieces_areas[1].get_parent().get_index()
		index += 1

	piece.reparent(pieces_holder)
	var new_position = Vector2(0,0)
	update_piece_position( piece, new_position )	
	pieces_holder.move_child(piece, index)
	print("library reposition: %s" % index)
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
