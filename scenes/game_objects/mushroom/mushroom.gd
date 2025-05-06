extends CharacterBody2D

@onready var health_component: Node = $HealthComponent

var max_speed = 50

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var direction = get_direction_to_player()
	velocity = max_speed * direction
	move_and_slide()

func get_direction_to_player():
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player != null:
		return (player.global_position - global_position).normalized()
	return Vector2.ZERO

func _on_area_2d_area_entered(_area: Area2D) -> void:
	health_component.take_damage(5)
