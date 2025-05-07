extends Node

@export var end_screen: PackedScene

@onready var player: CharacterBody2D = $Back/Player

func _ready() -> void:
	player.health_component.died.connect(on_died)

func on_died():
	var end_screen_instance = end_screen.instantiate() as EndScreen
	add_child(end_screen_instance)
