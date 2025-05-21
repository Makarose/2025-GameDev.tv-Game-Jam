extends Area2D

signal hit_something


func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node2D):
	hit_something.emit()
