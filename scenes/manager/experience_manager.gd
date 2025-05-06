extends Node

var current_experience = 0

func _ready() -> void:
	Global.experienced_bottle_collected.connect(on_expirience_bottle_collected)

func on_expirience_bottle_collected(experience):
	current_experience += experience
	print(current_experience)
