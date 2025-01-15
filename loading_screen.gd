extends Node2D

# Preload the assets
var sprite_texture = preload("res://assets/sprite.png")
var sprite_texture2 = preload("res://art/Creatures/upper_torso.svg")
var background_texture = preload("res://assets/background.png")

<<<<<<<< HEAD:loading_screen.gd
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
========
func _ready():
	#print("Hello Rob!")
	# Create a new Sprite2D node for the background
	var background = Sprite2D.new()
	background.texture = background_texture
	background.position = Vector2(0, 0)
	add_child(background)
	
	# Create a new Sprite2D node for the sprite
	var sprite = Sprite2D.new()
	sprite.texture = sprite_texture
	sprite.position = Vector2(200, 200)
	add_child(sprite)
	
	var torso = Sprite2D.new()
	torso.texture = sprite_texture2
	torso.position = Vector2(100, 500)
	add_child(torso)
>>>>>>>> 23c7bfceaccd8286ddc2a474c514f60c7ff7e905:main.gd
