extends CanvasLayer


@onready var health_label: Label = $MarginContainer/HBoxContainer/HealthCount
@onready var projectile_label: Label = $MarginContainer/HBoxContainer/ProjectileCount
@onready var distance_label: Label = $MarginContainer/HBoxContainer/DistanceClimbed


func _ready() -> void:
	SignalBus.projectile_count_updated.connect(func(new_projectile_count):
		_on_projectile_count_updated(new_projectile_count)
		)
	SignalBus.distance_updated.connect(func(distance):
		_on_distance_updated(distance)
		)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_projectile_count_updated(new_projectile_count) -> void:
	projectile_label.text = str(new_projectile_count)


func _on_distance_updated(distance) -> void:
	distance_label.text = "height: " + str(distance) + "'"
