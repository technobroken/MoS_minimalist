extends Control
class_name TopBar

enum EActions{
	ATTACK_CITY_ACTION,PRODUCTION_CITY_ACTION,TROOPS_CITY_ACTION,
	REPORTS_ACTION
}
signal sig_menu_button_pressed()
signal sig_city_action()
onready var _RawMaterials:=$ColorRect/MarginContainer/HBoxContainer/RawMaterials as RawMaterialsTopBar
onready var _CityActions:=$ColorRect/MarginContainer/HBoxContainer/CityActions as Control
onready var _EnemyAction:=$ColorRect/MarginContainer/HBoxContainer/EnemyActions as Control
onready var _MenuButton:=$ColorRect/MarginContainer/HBoxContainer/MenuButton as TextureButton
var _city_obj:CityObj

func set_city(city_obj:CityObj)->void:
	if city_obj is HumanCityObj:
		_city_obj=city_obj
	_EnemyAction.visible=city_obj is NpcCityObj

func _ready()->void:
	pass # Replace with function body.

func _process(_delta:float)->void:
	if _city_obj!=null:
		_RawMaterials.set_materials(_city_obj._raw_materials)

func _on_ReportsButton_pressed()->void:
	emit_signal("sig_city_action",EActions.REPORTS_ACTION)
 
func _on_ProductionButton_pressed()->void:
	emit_signal("sig_city_action",EActions.PRODUCTION_CITY_ACTION)

func _on_TroopsButton_pressed()->void:
	emit_signal("sig_city_action",EActions.TROOPS_CITY_ACTION)

func _on_AttackButton_pressed()->void:
	emit_signal("sig_city_action",EActions.ATTACK_CITY_ACTION)

func _on_MenuButton_pressed()->void:
	emit_signal("sig_menu_button_pressed")
