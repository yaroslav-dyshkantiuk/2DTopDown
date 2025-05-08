extends Node

@export var experience_manager: ExperienceManager
@export var upgrade_pool: Array[AbilityUpgrade]
@export var upgrade_screen_scene: PackedScene

var current_upgrades = {}

func _ready() -> void:
	experience_manager.level_up.connect(on_level_up)

func on_level_up(_current_level):
	var choosen_upgrade = upgrade_pool.pick_random() as AbilityUpgrade
	if choosen_upgrade == null:
		return
	var upgrade_screen_instance = upgrade_screen_scene.instantiate() as UpgradeScreen
	add_child(upgrade_screen_instance)
	upgrade_screen_instance.set_ability_upgrades([choosen_upgrade] as Array[AbilityUpgrade])
	upgrade_screen_instance.upgrade_selected.connect(on_upgrade_selected)

func apply_upgrade(upgrade: AbilityUpgrade):
	var has_upgrade = current_upgrades.has(upgrade.id)
	if !has_upgrade:
		current_upgrades[upgrade.id] = {
			"upgrade": upgrade,
			"quantity": 1
		}
	else:
		current_upgrades[upgrade.id]["quantity"] += 1
	
	Global.ability_upgrade_added.emit(upgrade, current_upgrades)

func on_upgrade_selected(upgrade: AbilityUpgrade):
	apply_upgrade(upgrade)
