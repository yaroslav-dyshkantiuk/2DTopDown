extends Node

@export var experience_manager: ExperienceManager
@export var upgrade_pool: Array[AbilityUpgrade]
@export var upgrade_screen_scene: PackedScene

var current_upgrades = {}

func _ready() -> void:
	experience_manager.level_up.connect(on_level_up)


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

func pick_upgrades():
	var choosen_upgrades: Array[AbilityUpgrade]
	var pool_copy = upgrade_pool.duplicate()
	for i in 2:
		var choosen_upgrade = pool_copy.pick_random() as AbilityUpgrade
		choosen_upgrades.append(choosen_upgrade)
		pool_copy = pool_copy.filter(func(upgrade): return upgrade.id != choosen_upgrade.id)
	
	return choosen_upgrades

func on_level_up(_current_level):

	var upgrade_screen_instance = upgrade_screen_scene.instantiate() as UpgradeScreen
	add_child(upgrade_screen_instance)
	var choosen_upgrades = pick_upgrades()
	upgrade_screen_instance.set_ability_upgrades(choosen_upgrades as Array[AbilityUpgrade])
	upgrade_screen_instance.upgrade_selected.connect(on_upgrade_selected)


func on_upgrade_selected(upgrade: AbilityUpgrade):
	apply_upgrade(upgrade)
