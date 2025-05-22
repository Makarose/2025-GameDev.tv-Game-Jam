class_name GlobalManager
extends Node


signal projectile_count_updated(count: int)
signal distance_updated(distance: int)


var player_health: int = 3
var projectile_count: int = 0:
	set(value):
		projectile_count = value
		projectile_count_updated.emit(value)
var distance_climbed: int = 0:
	set(value):
		distance_climbed = convert_distance_to_feet(value)
		distance_updated.emit(distance_climbed)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func convert_distance_to_feet(pixel_distance: int) -> int:
	return round(pixel_distance / 100)
