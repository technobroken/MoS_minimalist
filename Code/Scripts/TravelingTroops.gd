extends Area2D
class_name TravelingTroops

signal sig_attack_done()
enum EState{TRAVELING,IN_BATTLE}
export var Speed:int=50
var _speed:float
var _direction:Vector2
var _source_city:City
var _attack_troops_obj:TroopsObj
var _state:int
	
func init(source:City,target:City,attack_troops_obj:TroopsObj)->void:
	_source_city=source
	_attack_troops_obj=attack_troops_obj
	global_position=source.global_position
	_direction=source.global_position.direction_to(target.global_position)
	_state=EState.TRAVELING

func _ready()->void:
	_speed=Speed

func _process(delta:float)->void:
	position+=_direction*_speed*delta

func _on_TravelingTroops_area_entered(area:Area2D)->void:
	var city:=area as City
	_state=EState.IN_BATTLE
	_direction=Vector2.ZERO
	var attack_report:=CombatSimulator.simulate_combat(_attack_troops_obj,city)
	attack_report.source_city=_source_city._city_obj
	attack_report.target_city=city._city_obj
	attack_report.ofensive_tribe_key=_source_city.TribeKey
	attack_report.defense_tribe_key=city.TribeKey
	_source_city._city_obj._troops.apply_altas(_attack_troops_obj)
	emit_signal("sig_attack_done",attack_report)
	yield(get_tree().create_timer(.5),"timeout")
	queue_free()
