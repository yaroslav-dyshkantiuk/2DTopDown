extends Node2D

@onready var collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D

var bottle_expience = 1


func disable_collision():
	collision_shape_2d.disabled = true


func tween_exp_bottle(percent: float, start_position: Vector2):
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return
	
	global_position = start_position.lerp(player.global_position, percent)
	
	var direction = player.position - start_position
	var direction_degrees = rad_to_deg(direction.angle())
	
	rotation = lerp_angle(rotation, direction_degrees, 0.05)


func exp_collected():
	Global.experienced_bottle_collected.emit(bottle_expience)
	queue_free()


func _on_area_2d_area_entered(_area: Area2D) -> void:
	Callable(disable_collision).call_deferred()
	var tweeen = create_tween()
	tweeen.tween_method(tween_exp_bottle.bind(global_position), 0.0, 1.0, 0.5)\
	.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_BACK)
	tweeen.tween_callback(exp_collected)
