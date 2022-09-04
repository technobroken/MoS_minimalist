extends City
class_name NpcCity

onready var _Timer:=$Timer
var _target_city:City

func set_target_city(city:City)->void:
	_target_city=city

func _ready()->void:
	_city_obj=NpcCityObj.new(TribeKey)

func _on_Timer_timeout()->void:
	if _active:
		if _check_condition_for_defense():
			.try_add_troop("T2")
		elif _check_condition_for_ofense():
			.try_add_troop("T1")
		if _check_condition_for_attack():
			var troop_amounts:={}
			for troop_key in _city_obj._troops.get_troop_keys():
				troop_amounts[troop_key]=_city_obj._troops.count_troop(troop_key)
			var troops:=TroopsObj.new(troop_amounts)
			.attack_to(_target_city,troops)

func _check_condition_for_defense()->bool:
	var defense:=_city_obj._troops.get_defense_points()
	var attack:=_target_city._city_obj._troops.get_attack_points()
	var diff:=attack-defense
	if diff>0 and diff>0.2*defense:
		return true
	return false

func _check_condition_for_ofense()->bool:
	var ofensive:=_city_obj._troops.get_attack_points()
	var defense:=_target_city._city_obj._troops.get_defense_points()
	var diff:=defense-ofensive
	if diff>=0 and diff>=0.2*ofensive:
		return true
	return false

func _check_condition_for_attack()->bool:
	var ofensive:=_city_obj._troops.get_attack_points()
	var defense:=_target_city._city_obj._troops.get_defense_points()
	var diff:=ofensive-defense
	if diff>0 and diff>0.5*ofensive:
		return true
	return false
