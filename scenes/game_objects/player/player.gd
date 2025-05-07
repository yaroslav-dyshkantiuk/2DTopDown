extends CharacterBody2D

@onready var health_component: HealthComponent = $HealthComponent
@onready var grace_period: Timer = $GracePeriod
@onready var progress_bar: ProgressBar = $ProgressBar

var max_speed = 125
var acceleration = .15
var enemies_colliding = 0

func _ready() -> void:
	health_component.died.connect(on_died)
	health_component.health_changed.connect(on_health_changed)
	health_update()

func _process(_delta: float) -> void:
	var direction = movement_vector()
	var target_velocity = max_speed * direction
	velocity = velocity.lerp(target_velocity, acceleration)
	move_and_slide()

func movement_vector():
	var movement_x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var movement_y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	return Vector2(movement_x, movement_y).normalized()

func check_if_damage():
	if enemies_colliding == 0 || !grace_period.is_stopped():
		return
	health_component.take_damage(1)
	grace_period.start()

func _on_player_hurt_box_area_entered(_sarea: Area2D) -> void:
	enemies_colliding += 1
	check_if_damage()

func health_update():
	progress_bar.value = health_component.get_health_value()
	

func _on_player_hurt_box_area_exited(_area: Area2D) -> void:
	enemies_colliding -= 1

func on_died():
	queue_free()

func on_health_changed():
	health_update()

func _on_grace_period_timeout() -> void:
	check_if_damage()
