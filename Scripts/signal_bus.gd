class_name GlobalManager
extends Node


signal player_health_updated(health: int)
signal player_damage
signal player_death
signal projectile_count_updated(count: int)
signal distance_updated(distance: int)


var player_health: int = 3:
	set(value):
		player_health = value
		player_health_updated.emit(player_health)
		if player_health <= 0:
			player_death.emit()
		else:
			player_damage.emit()
var projectile_count: int = 0:
	set(value):
		projectile_count = value
		projectile_count_updated.emit(projectile_count)
var distance_climbed: int = 0:
	set(value):
		distance_climbed = convert_distance_to_feet(value)
		distance_updated.emit(distance_climbed)


func convert_distance_to_feet(pixel_distance: int) -> int:
	return round(pixel_distance / 50)
