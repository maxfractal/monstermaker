#===============================================================================
# class: PieceField
#
#	parent class to hold Monster Pieces.  This could be an ordered library or 
#	Monster creation area.
#
# TODO
# - 
#===============================================================================
class_name PieceField extends MarginContainer
#extends Field

#-------------------------------------------------------------------------------
# constants
#-------------------------------------------------------------------------------
#const DEBUG_MODE = true;

#-------------------------------------------------------------------------------
# variables
#-------------------------------------------------------------------------------
#@onready var pieces_scroller: ScrollContainer = $MarginContainer/PartsScrollContainer

#-------------------------------------------------------------------------------
# preloads
#-------------------------------------------------------------------------------
# load the monster piece scene ONCE so it can be instantiated when loading the library
var new_piece_scene = preload("res://project/monsterpiece/monster_piece.tscn")

#-------------------------------------------------------------------------------
# class virtual functions
#-------------------------------------------------------------------------------
func monsterpiece_reposition(piece: MonsterPiece) -> void:
	pass
	
func return_monsterpiece_starting_position(part: MonsterPiece) -> void:
	pass

func set_new_monsterpiece(part: MonsterPiece) -> void:
	pass

#-------------------------------------------------------------------------------
# parent functions
#-------------------------------------------------------------------------------
func update_piece_position(piece: MonsterPiece, new_position: Vector2) -> void:
	piece.drop_point_detector.position = new_position
	piece.drop_point_collision_shape.position = new_position
	piece.piece_detector.position = new_position
	#for child in piece.piece_detector.get_children():
			#child.position = new_position
	piece.setPosition( new_position )

	
#	generate_piece will
#		- load the image (texture)
#		- upon success, instatiate a new piece
#		- attach the image to the piece
#		- add the piece to the piece container
#
func generate_piece(pieces_holder, texture_file_path):
	var loadedTexture = load(texture_file_path)
	if loadedTexture == null:
		print("ERROR: Failed to load texture from path:", texture_file_path)
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
	#new_part.position = Vector2(0,0)
	#new_part.size = Vector2(50,50)
	new_part.home_field = self			# set the "parent" of drop to this library
	
	# fill in the textureRect, set the new texture, then add it to the new piece
	new_part.icon_texture_rect.texture = loadedTexture
	#new_part.icon_texture_rect.visible = false
	#new_part.icon_texture_rect.visible = not new_part.icon_texture_rect.visible
	new_part.piece_texture_rect.texture = loadedTexture
	#new_part.piece_texture_rect.set_position(Vector2(0,0))

	# set part + texture variables	
	#new_part.y_sort_enabled = true
	#new_part.z_index = 10
	#new_part.piece_texture_rect.z_index = 20
	#new_part.icon_texture_rect.texture.y_sort_enabled = true

	# set up the collision shape
	var rect = CollisionShape2D.new()
	var the_shape = RectangleShape2D.new()
	rect.shape = the_shape
	new_part.piece_detector.add_child(rect)
	rect.position = Vector2(50,50)
	the_shape.set_size(Vector2(100,100))
	#new_part.piece_collision_shape = rect
	
	#the_shape.extents = Vector2(51, 51)
	#the_shape.size = Vector2(50, 50)

	#print("\t\t\t\t\tpiece z    " + str(new_part.z_index))
	#print("\t\t\t\t\tpiece spos " + str(new_part.get_screen_position()))
	#print("\t\t\t\t\tpiece rect " + str(new_part.get_rect()))
	#print("\t\t\t\t\tpiece globl" + str(new_part.get_global_rect()))
	#print("\t\t\t\t\ttexture pos" + str(new_part.piece_texture_rect.get_position()))
	#print("\t\t\t\t\ttexture siz" + str(new_part.piece_texture_rect.get_size()))
	#print("\t\t\t\t\ttexture off" + str(new_part.piece_texture_rect.get_pivot_offset()))
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
func scale_texture(piece_texture_rect, width_max):
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
			new_width = min(width_max, texture_size.x)
			new_height = new_width * aspect_ratio
		else:
			aspect_ratio = texture_size.x / texture_size.y
			new_height = min(width_max, texture_size.y)
			new_width = new_height * aspect_ratio
		#print("--------new size (%d" % new_width + ",%4d" % new_height + ")")
		return Vector2(new_width, new_height)
	return Vector2(1,1)

#-------------------------------------------------------------------------------
# class functions
#-------------------------------------------------------------------------------
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
