extends CanvasLayer


@onready var health_label: Label = $MarginContainer/HBoxContainer/HealthLabel
@onready var projectile_label: Label = $MarginContainer/HBoxContainer/ProjectileLabel


func _ready() -> void:
	SignalBus.projectile_count_updated.connect(func(new_projectile_count):
		_on_projectile_count_updated(new_projectile_count)
		)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_projectile_count_updated(new_projectile_count) -> void:
	projectile_label.text = "x" + str(new_projectile_count)
