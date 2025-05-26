extends Node2D

enum States { MOVE, DAMAGE, DEATH }

@export var end_screen: PackedScene

@onready var camera_2d: Camera = $Camera2D
@onready var level_generator: Node2D = $LevelGenerator
@onready var player: Player = $Player
@onready var ring_boundary: RingBoundary = $RingBoundary
@onready var falling_item_generator: Area2D = $FallingItemGenerator
@onready var pause_screen: CanvasLayer = $PauseScreen

var viewport_size: Vector2


func _ready() -> void:
	camera_2d.setup_camera(player)
	level_generator.setup(player)
	
	viewport_size = get_viewport_rect().size
	
	SignalBus.player_health = 3
	SignalBus.distance_climbed = 0
	SignalBus.can_create_enemy = false
	
	SignalBus.player_damage.connect(_on_player_damage)
	SignalBus.player_death.connect(_on_player_death)
	
	player.player_crunched.connect(_on_player_crunched)
	player.game_over.connect(_on_game_over)


func _process(delta: float) -> void:
	# Check height reached and switch on game mechanics depending on no. of feet
	enable_mechanics_by_height()
	
	# Set FallingItemGenerator position to match RingBoundary position
	falling_item_generator.position = Vector2(0, ring_boundary.position.y)
	
	# Check if player has fallen below lower screen boundary and end game if it has
	var camera_center = camera_2d.get_screen_center_position()
	var player_position = player.global_position
	var bottom_of_screen: int = camera_center.y + (viewport_size.y / 2)
	if (player_position.y - 256) > bottom_of_screen:
		player.state = States.DEATH


func enable_mechanics_by_height() -> void:
	match SignalBus.distance_climbed:
		25:
			SignalBus.can_create_enemy = true
		30:
			ring_boundary.can_contract = true
		100:
			falling_item_generator.can_generate_bananas = true
		120:
			falling_item_generator.can_generate_oranges = true


func _on_player_damage() -> void:
	SfxManager.play_sfx("LoseLifeSingle1")
	player.state = States.DAMAGE
	camera_2d.add_trauma(0.3)


func _on_player_death() -> void:
	SfxManager.play_sfx("LoseLifeFinal")
	player.state = States.DEATH


func _on_player_crunched() -> void:
	ring_boundary.can_contract = false


func _on_game_over() -> void:
	get_tree().change_scene_to_packed(end_screen)
