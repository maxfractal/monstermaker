class_name Library extends MarginContainer
#extends Field

@onready var parts_holder: VBoxContainer = $PartsScrollContainer/PartsContainer
@onready var part_drop: Area2D = $LibraryPartDrop

var folder_path = "res://art/Creatures/Pirate/"  # Replace with your folder path
#var folder_path = "res://art/Creatures/Skeleton/"  # Replace with your folder path
var library_max_tile_width = 100 
var library_max_tile_height = 100 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Library ready start")
	$LibraryTitle.text = name
	
	#start debug info -----------------------------------------------
	print("  Folder path:", folder_path)
	
	#var canvas_layer = get_node("CanvasLayer")
	#if canvas_layer == null:
		#print("CanvasLayer node not found")
		#return
#
	#print("  Children of canvas layer node:")
	#for child in canvas_layer.get_children():
		#print("   %s" % child.name)
#
	#var field_container = canvas_layer.get_node("Library")
	#if field_container == null:
		#print("Library node not found")
		#return

	var scroll_container = get_node("PartsScrollContainer")
	if scroll_container == null:
		print("PartsScrollContainer node not found")
		return
	parts_holder = scroll_container.get_node("PartsContainer")
	if parts_holder == null:
		print("PartsContainer node not found")
		return
	#end debug info -------------------------------------------------
	
	# hook up the pre-made parts to the parent PartsHolder
	#for child in parts_holder.get_children():
		#print("part %s" %child.name)
		#var part := child as Part
		#part.home_field = self
		
	# cycle through a creature parts folder + build parts for each part
	load_Library()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func load_Library():
	print("Start loading library")
	print("  Folder path:", folder_path)
	
	#var canvas_layer = get_node("CanvasLayer")
	#if canvas_layer == null:
		#print("CanvasLayer node not found")
		#return
#
	#print("  Children of canvas layer node:")
	#for child in canvas_layer.get_children():
		#print("   %s" % child.name)

	var scroll_container = get_node("PartsScrollContainer")
	if scroll_container == null:
		print("PartsScrollContainer node not found")
		return
	parts_holder = scroll_container.get_node("PartsContainer")
	if parts_holder == null:
		print("PartsContainer node not found")
		return
	
	#load_images_from_folder( scroll_container, parts_holder )
	#check_for_scroll(scroll_container, vbox_container)

func load_images_from_folder( scroll_container, parts_holder ):
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
				display_image(file_path, scroll_container, parts_holder)
			file_name = dir.get_next()

func display_image(file_path, scroll_container, parts_holder):
	var texture = load(file_path)
	if texture == null:
		print("ERROR: Failed to load texture from path:", file_path)
		return false
	print("        texture loaded: %s" % file_path)
	var texture_rect = TextureRect.new()
	texture_rect.texture = texture
	
	scale_texture(texture_rect)
	
	var new_part = Part.new()
	parts_holder.add_child(new_part)
	#parts_holder.add_child(texture_rect)

func scale_texture(texture_rect):
	if texture_rect.texture:
		var texture_size = texture_rect.texture.get_size()
		var aspect_ratio
		var new_width
		var new_height
		print("          old size (%d" % texture_size.x + ",%4d" % texture_size.y + ")")
		if texture_size.x > texture_size.y:
			aspect_ratio = texture_size.y / texture_size.x
			new_width = min(library_max_tile_width, texture_size.x)
			new_height = new_width * aspect_ratio
		else:
			aspect_ratio = texture_size.x / texture_size.y
			new_height = min(library_max_tile_width, texture_size.y)
			new_width = new_height * aspect_ratio
		print("          new size (%d" % new_width + ",%4d" % new_height + ")")
		texture_rect.set_size(Vector2(new_width, new_height))
		texture_rect.expand = true;
		texture_rect.expand_mode = TextureRect.EXPAND_FIT_HEIGHT_PROPORTIONAL
		texture_rect.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT

func check_for_scroll(scroll_container, vbox_container):
	if vbox_container.get_child_count() > 10:
		scroll_container.scroll_vertical_enabled = true
	else:
		scroll_container.scroll_vertical_enabled = false

func return_part_starting_position(part: Part):
	part.reparent(parts_holder)
	parts_holder.move_child(part, part.index)


func set_new_part(part: Part):
	part_reposition(part)
	part.home_field = self


func part_reposition(part: Part):
	var field_areas = part.drop_point_detector.get_overlapping_areas()
	var parts_areas = part.part_detector.get_overlapping_areas()
	var index: int = 0
	
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

	part.reparent(parts_holder)
	parts_holder.move_child(part, index)
	
	
