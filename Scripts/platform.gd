class_name Platform
extends StaticBody2D

# Projectile pickup
@export var projectile_pickup: PackedScene
@export var projectile_width: int
# Slime enemy
@export var slime_enemy: PackedScene
@export var slime_enemy_width: int

var platform_sprite_width: int
var platform_position: Vector2
var pickup_left_margin: int = 20
var pickup_y_pos: int = -50
var enemy_margin = 50
var enemy_y_pos: int
var enemy_created: bool = false

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D


func _ready() -> void:
	# Get the width of the sprite for whichever platform type this script is attached to
	platform_sprite_width = get_sprite_width(sprite_2d)
	# Get Y position of collision shape
	enemy_y_pos = collision_shape.position.y - 35
	# Add random pickup, enemies, etc.
	add_random_objects()


func get_sprite_width(sprite: Sprite2D) -> int:
	var sprite_width = sprite.get_rect().size.x * sprite.scale.x
	return sprite_width


func add_random_objects() -> void:
	var slots = floor(platform_sprite_width / projectile_width)
	for i in slots:
		var pickup_x_pos: int = (i * projectile_width) + pickup_left_margin
		var random_number = randi_range(0, 19)
		if random_number <= 2:
			var new_pickup = projectile_pickup.instantiate()
			add_child(new_pickup)
			new_pickup.position = Vector2(pickup_x_pos, pickup_y_pos)
		elif random_number >= 18 and (pickup_x_pos + slime_enemy_width < platform_sprite_width) and SignalBus.can_create_enemy:
			if not enemy_created:
				enemy_created = true
				var new_enemy = slime_enemy.instantiate()
				add_child(new_enemy)
				new_enemy.position = Vector2(clampi(pickup_x_pos, enemy_margin, platform_sprite_width - enemy_margin), enemy_y_pos)
