extends Node2D

@export var y_distance_between_platforms = 250
@export var platforms_array: Array[PackedScene]

# Level gen variables
var viewport_size
var start_platform_y
var level_size = 50
var generated_platform_count = 0
var platform_width: int = 150
var platforms_array_size: int

var player: Player = null

@onready var platform_parent = $PlatformParent


func _ready():
	# Get dimensions for this platform TODO: create method to figure dimensions of platform once instantiated
	#platform_width = sprite_2d.get_rect().size.x * sprite_2d.scale.x
	
	# Get number of elements in platform array
	if not platforms_array.is_empty():
		platforms_array_size = platforms_array.size()
	
	# Generate level
	viewport_size = get_viewport_rect().size
	generated_platform_count = 0
	start_platform_y = viewport_size.y - (y_distance_between_platforms) # * 2
	generate_level(start_platform_y)


func _process(_delta):
	if player:
		var py = player.global_position.y
		var end_of_level_pos = start_platform_y - (generated_platform_count * y_distance_between_platforms)
		var threshold = end_of_level_pos + (y_distance_between_platforms * 6)
		if py <= threshold:
			generate_level(end_of_level_pos)


func setup(_player: Player):
	if _player:
		player = _player


func create_platform():
	var index: int = randi_range(0, platforms_array_size - 1)
	var random_platform = platforms_array[index]
	var new_platform = random_platform.instantiate()
	platform_parent.add_child(new_platform)
	
	return new_platform


func generate_level(start_y: float):
	# Generate two randomly-selected platforms per y-position
	var max_x_position_left = viewport_size.x / 2
	var max_x_position_right = viewport_size.x
	for i in range(level_size):
		# Generate left screen platform
		var left_platform = create_platform()
		# TODO: refactor below line, it is ugly
		var left_sprite_width = left_platform.get_node("Sprite2D").get_rect().size.x * left_platform.get_node("Sprite2D").scale.x
		var random_x_left = randf_range(0.0, max_x_position_left - left_sprite_width)
		var location_left: Vector2 = Vector2.ZERO
		location_left.x = random_x_left
		location_left.y = start_y - (i * y_distance_between_platforms)
		left_platform.global_position = location_left
		
		
		# Generate right screen platform
		var right_platform = create_platform()
		# TODO: refactor below line, it is ugly
		var right_sprite_width = right_platform.get_node("Sprite2D").get_rect().size.x * right_platform.get_node("Sprite2D").scale.x
		var random_x_right = randf_range(max_x_position_left, max_x_position_right - right_sprite_width)
		var location_right: Vector2 = Vector2.ZERO
		location_right.x = random_x_right
		location_right.y = start_y - (i * y_distance_between_platforms)
		right_platform.global_position = location_right
		
		# Two platforms on one line counts as one platform for purpose of calculating y-distance
		generated_platform_count += 1
