extends CharacterBody2D

@onready var health_component: HealthComponent = $HealthComponent

var max_speed = 50

func _ready() -> void:
	health_component.died.connect(on_died)

func _process(_delta: float) -> void:
	var direction = get_direction_to_player()
	velocity = max_speed * direction
	move_and_slide()

func get_direction_to_player():
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player != null:
		return (player.global_position - global_position).normalized()
	return Vector2.ZERO

func on_died():
	queue_free()
