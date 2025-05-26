extends Area2D

@export var banana_bunch: PackedScene
@export var orange: PackedScene

@export var can_generate_bananas: bool = false
@export var can_generate_oranges: bool = false

@onready var collision_shape: CollisionShape2D = $CollisionShape2D

var viewport_size: Vector2


func _ready() -> void:
	viewport_size = get_viewport_rect().size


func _process(delta: float) -> void:
	var random_number: int = randi_range(0, 30)
	if can_generate_bananas:
		if random_number <= 5:
			generate_bananas()
	if can_generate_oranges:
		if random_number >= 26:
			generate_orange()


func generate_bananas() -> void:
	var new_banana_bunch = banana_bunch.instantiate()
	var x_pos: int = randi_range(0, viewport_size.x)
	var y_pos: int = collision_shape.global_position.y
	new_banana_bunch.global_position = Vector2(x_pos, y_pos)
	add_child(new_banana_bunch)


func generate_orange() -> void:
	var new_orange = orange.instantiate()
	var x_pos: int = randi_range(0, viewport_size.x)
	var y_pos: int = collision_shape.global_position.y
	new_orange.global_position = Vector2(x_pos, y_pos)
	add_child(new_orange)
