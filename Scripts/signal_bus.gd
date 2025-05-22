class_name GlobalManager
extends Node


signal projectile_count_updated(count: int)

var player_health: int = 3
var projectile_count: int = 0:
	set(value):
		projectile_count = value
		projectile_count_updated.emit(value)
		print("Projectile Count: " + str(projectile_count))
var distance_climbed: float = 0.0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
