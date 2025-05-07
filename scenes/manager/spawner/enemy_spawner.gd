extends Node

@onready var timer: Timer = $Timer

@export var mushroom_scene: PackedScene
@export var arena_time_manager: ArenaTimeManager

var base_spawn_time
var min_spawn_time = 0.2
var difficulty_multiplier = 0.01

func _ready() -> void:
	base_spawn_time = timer.wait_time
	arena_time_manager.difficulty_increased.connect(on_difficulty_increased)

func get_spawn_position(player: Node2D):
	var spawn_position = Vector2.ZERO
	var random_direction = Vector2.RIGHT.rotated(randf_range(0, TAU))
	var random_distance = randi_range(380, 500)
	
	for i in 24:
		spawn_position = player.global_position + (random_direction * random_distance)
		var raycast = PhysicsRayQueryParameters2D.create(player.global_position, spawn_position, 1)
		var intersection = get_tree().root.world_2d.direct_space_state.intersect_ray(raycast)
		
		if intersection.is_empty():
			return spawn_position
		else:
			random_direction = random_direction.rotated(deg_to_rad(15))
		
	return null

func _on_timer_timeout() -> void:
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return

	var spawn_position = get_spawn_position(player)
	if spawn_position == null:
		return
	
	var enemy = mushroom_scene.instantiate() as Node2D
	var back_layer = get_tree().get_first_node_in_group("back_layer")
	back_layer.add_child(enemy)
	
	enemy.global_position = spawn_position

func on_difficulty_increased(diffuculty_level: int):
	var new_spawn_time = max(min_spawn_time,base_spawn_time - (diffuculty_level * difficulty_multiplier))
	timer.wait_time = new_spawn_time
	print(timer.wait_time)
