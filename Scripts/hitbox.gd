extends Area2D


signal hit_something


func _ready() -> void:
	body_entered.connect(_on_body_entered)
	area_entered.connect(_on_area_entered)


func _on_body_entered(body: Node2D):
	if body.name == "RingBoundary":
		hit_something.emit()
		body.expand_ring()


func _on_area_entered(area: Node2D) -> void:
	if area is SlimeEnemy:
		hit_something.emit()
		area.slime_take_damage()
