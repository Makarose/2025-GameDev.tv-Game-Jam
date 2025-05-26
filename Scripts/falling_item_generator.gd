extends Area2D

@export var banana_bunch: PackedScene
@export var orange: PackedScene

@export var can_generate_bananas: bool = false:
	set(value):
		can_generate_bananas = value
		if can_generate_bananas:
			banana_timer.start()
@export var can_generate_oranges: bool = false:
	set(value):
		can_generate_oranges = value
		if can_generate_oranges:
			orange_timer.start()

@onready var banana_timer: Timer = $BananaTimer
@onready var orange_timer: Timer = $OrangeTimer

var viewport_size: Vector2


func _ready() -> void:
	viewport_size = get_viewport_rect().size
	banana_timer.timeout.connect(generate_bananas)
	orange_timer.timeout.connect(generate_orange)


func generate_bananas() -> void:
	print("banana!")
	var new_banana_bunch = banana_bunch.instantiate()
	var x_pos: int = randi_range(0, viewport_size.x)
	var y_pos: int = global_position.y
	new_banana_bunch.global_position = Vector2(x_pos, y_pos)
	add_child(new_banana_bunch)


func generate_orange() -> void:
	print("orange!")
	var new_orange = orange.instantiate()
	var x_pos: int = randi_range(0, viewport_size.x)
	var y_pos: int = global_position.y
	new_orange.global_position = Vector2(x_pos, y_pos)
	add_child(new_orange)
