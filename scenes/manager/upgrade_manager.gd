extends Node

@export var experience_manager: ExperienceManager
@export var upgrade_pool: Array[AbilityUpgrade]
@export var upgrade_screen_scene: PackedScene

var current_upgrades = {}

func _ready() -> void:
	experience_manager.level_up.connect(on_level_up)

func on_level_up(current_level):
	var choosen_upgrade = upgrade_pool.pick_random() as AbilityUpgrade
	if choosen_upgrade == null:
		return
	var upgrade_scene_instance = upgrade_screen_scene.instantiate() as UpgradeScreen
	add_child(upgrade_scene_instance)
	upgrade_scene_instance.set_ability_upgrades([choosen_upgrade] as Array[AbilityUpgrade])

func apply_upgrade(upgrade: AbilityUpgrade):
	var has_upgrade = current_upgrades.has(upgrade.id)
	if !has_upgrade:
		current_upgrades[upgrade.id] = {
			"upgrade": upgrade,
			"quantity": 1
		}
	else:
		current_upgrades[upgrade.id]["quantity"] += 1
