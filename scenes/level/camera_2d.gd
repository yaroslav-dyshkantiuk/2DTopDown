extends Camera2D

@onready var player: CharacterBody2D = $"../BackLayer/Player"  as Node2D

func _process(_delta: float) -> void:
	if player == null:
		return
	global_position = player.global_position
