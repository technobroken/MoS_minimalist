extends Area2D
class_name TravelingTroops

var _speed:float=300
var _direction:Vector2
var _source_city:City
var _attack_troops_obj:TroopsObj
	
func init(source:City,target:City,attack_troops_obj:TroopsObj)->void:
	_source_city=source
	_attack_troops_obj=attack_troops_obj
	global_position=source.global_position
	_direction=source.global_position.direction_to(target.global_position)

func _ready()->void:
	pass # Replace with function body.

func _process(delta:float)->void:
	position+=_direction*_speed*delta

func _on_TravelingTroops_area_entered(area:Area2D)->void:
	var city:=area as City
	CombatSimulator.simulate_combat(_attack_troops_obj,city._city_obj._troops)
	_source_city._city_obj._troops.apply_altas(_attack_troops_obj)
	queue_free()
