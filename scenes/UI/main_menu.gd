extends CanvasLayer

var options_menu_scene = preload("res://scenes/UI/options_menu.tscn")


func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level/level.tscn")


func _on_options_button_pressed() -> void:
	print("Options")
	var options_instance = options_menu_scene.instantiate()
	add_child(options_instance)

func _on_quit_button_pressed() -> void:
	get_tree().quit()
