extends Node2D


@onready var camera_2d: Camera = $Camera2D
@onready var player: Player = $Player


func _ready() -> void:
	camera_2d.setup_camera(player)


func _process(delta: float) -> void:
	pass
