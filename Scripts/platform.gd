class_name Platform
extends StaticBody2D


@export var projectile_pickup: PackedScene
@export var projectile_width: int

var platform_sprite_width: int
var platform_position: Vector2
var pickup_left_margin: int = 20

@onready var sprite_2d: Sprite2D = $Sprite2D


func _ready() -> void:
	# Get the width of the sprite for whichever platform type this script is attached to
	platform_sprite_width = get_sprite_width(sprite_2d)
	
	# Add random pickup, enemies, etc.
	add_random_objects()


func get_sprite_width(sprite: Sprite2D) -> int:
	var sprite_width = sprite.get_rect().size.x * sprite.scale.x
	return sprite_width


func add_random_objects() -> void:
	var slots = floor(platform_sprite_width / projectile_width)
	for i in slots:
		var random_number = randi_range(0, 9)
		if random_number <= 2:
			var new_pickup = projectile_pickup.instantiate()
			var pickup_x_pos: int = (i * projectile_width) + pickup_left_margin
			var pickup_y_pos: int = -50
			add_child(new_pickup)
			new_pickup.position = Vector2(pickup_x_pos, pickup_y_pos)
