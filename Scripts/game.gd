extends Node2D


@onready var camera_2d: Camera = $Camera2D
@onready var level_generator: Node2D = $LevelGenerator
@onready var player: Player = $Player


func _ready() -> void:
	camera_2d.setup_camera(player)
	level_generator.setup(player)


func _process(delta: float) -> void:
	pass
