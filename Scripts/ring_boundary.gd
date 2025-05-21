class_name RingBoundary
extends StaticBody2D


@export var contract_rate: float = 0.01
@export var expand_amount: float = 0.05


func _ready() -> void:
	visible = true


func _process(delta: float) -> void:
	scale -= Vector2(contract_rate, contract_rate) * delta


func expand_ring() -> void:
	scale += Vector2(expand_amount, expand_amount)
