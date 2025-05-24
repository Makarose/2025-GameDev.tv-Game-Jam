extends Node2D

enum States { MOVE, DAMAGE, DEATH }

@onready var camera_2d: Camera = $Camera2D
@onready var level_generator: Node2D = $LevelGenerator
@onready var player: Player = $Player
@onready var ring_boundary: RingBoundary = $RingBoundary


func _ready() -> void:
	camera_2d.setup_camera(player)
	level_generator.setup(player)
	
	SignalBus.player_damage.connect(_on_player_damage)
	SignalBus.player_death.connect(_on_player_death)
	
	player.player_crunched.connect(_on_player_crunched)
	player.game_over.connect(_on_game_over)


func _on_player_damage() -> void:
	player.state = States.DAMAGE


func _on_player_death() -> void:
	player.state = States.DEATH


func _on_player_crunched() -> void:
	ring_boundary.can_contract = false


func _on_game_over() -> void:
	print("GAME OVER")
