class_name RingBoundary
extends StaticBody2D


@export var can_contract: bool = false
@export var contract_rate: float = 0.01
@export var contract_acceleration: float = 0.0
@export var expand_amount: float = 0.05


func _ready() -> void:
	visible = true


func _process(delta: float) -> void:
	if scale.x <= 0.8:
		contract_acceleration = .005
	if can_contract:
		contract_rate += contract_acceleration
		scale -= Vector2(contract_rate, contract_rate) * delta


func expand_ring() -> void:
	SfxManager.play_sfx("HitEnemy2")
	if can_contract:
		scale += Vector2(expand_amount, expand_amount)
