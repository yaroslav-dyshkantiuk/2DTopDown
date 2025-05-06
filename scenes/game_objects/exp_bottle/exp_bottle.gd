extends Node2D

var bottle_expience = 5

func _on_area_2d_area_entered(_area: Area2D) -> void:
	Global.experienced_bottle_collected.emit(bottle_expience)
	queue_free()
