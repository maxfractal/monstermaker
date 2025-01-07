extends Node2D

# Preload the assets
var sprite_texture = preload("res://assets/sprite.png")
var background_texture = preload("res://assets/background.png")

func _ready():
	print("Hello Rob!")
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
