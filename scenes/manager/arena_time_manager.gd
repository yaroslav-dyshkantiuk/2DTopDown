extends Node
class_name ArenaTimeManager

signal difficulty_increased(diffuculty_level: int)

@export var end_screen: PackedScene

@onready var timer: Timer = $Timer
@onready var difficulty_timer: Timer = $DifficultyTimer

var difficulty_level: int = 0

func get_time_elapsed():
	return timer.wait_time - timer.time_left

func _on_timer_timeout() -> void:
	var end_screen_instance = end_screen.instantiate() as EndScreen
	get_parent().add_child(end_screen_instance)
	end_screen_instance.change_to_victory()
	end_screen_instance.play_jingle(true)

func _on_difficulty_timer_timeout() -> void:
	difficulty_level += 1
	difficulty_increased.emit(difficulty_level)
