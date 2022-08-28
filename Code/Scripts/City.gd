extends Area2D
class_name City

signal sig_pressed()
signal sig_throw_attack()
const STAYING_TROOP_PREFAB:=preload("res://Prefabs/StayingTroops.tscn")
export var TribeKey:String
onready var _Troops:=$Troops as Node2D
var _city_obj:CityObj
var _time_count:float

func try_add_troop(troop_key:String)->bool:
	var troop_data:=Data.TROOPS[troop_key] as Dictionary
	var is_added:=_city_obj.try_add_troop(troop_key,troop_data)
	if is_added:
		var x:=STAYING_TROOP_PREFAB.instance() as StayingTroops
		x.Tint=$Sprite.self_modulate
		_Troops.add_child(x)
		_reposition_troops()
	return is_added

func remove_troops(troop_key:String,amount:int)->void:
	_city_obj._troops.remove_troop(troop_key,amount)
	while amount>0 and _Troops.get_child_count()>0:
		var node:=_Troops.get_child(0)
		_Troops.remove_child(node)
		node.queue_free()
		amount-=1
	_reposition_troops()

func attack_to(target_city:City,troops_obj:TroopsObj)->void:
	for troop_key in troops_obj._amounts:
		var amount:=int(troops_obj._amounts[troop_key])
		remove_troops(troop_key,amount)
	emit_signal("sig_throw_attack",self,target_city,troops_obj)

func apply_damage(factor:float)->void:
	_city_obj._troops.apply_bajas(factor)
	_fill_troops_node(_city_obj._troops)

func _ready()->void:
	_time_count=0

func _process(delta:float)->void:
	_time_count-=delta
	if _time_count<0:
		_city_obj.produce_materials()
		_time_count+=1
	$DebugTroops.text=str(_city_obj._troops)

func _on_Area2D_input_event(viewport:Node,event:InputEvent,shape_idx:int)->void:
	if event is InputEventMouseButton:
		if event.pressed:
			emit_signal("sig_pressed",self)

func _on_City_area_entered(area:Area2D)->void:
	pass # Replace with function body.

func _fill_troops_node(troops_obj:TroopsObj)->void:
	for node in _Troops.get_children():
		_Troops.remove_child(node)
		node.queue_free()
	for troop_key in troops_obj.get_troop_keys():
		var amount:=troops_obj.count_troop(troop_key)
		for i in amount:
			var x:=STAYING_TROOP_PREFAB.instance() as StayingTroops
			x.Tint=$Sprite.self_modulate
			_Troops.add_child(x)
	_reposition_troops()

func _reposition_troops()->void:
	var n:=_Troops.get_child_count()
	if n>0:
		var step:=360/n
		var value:=0
		var vector:=Vector2(10 if n>1 else 0,0)
		for i in range(n):
			var child:=_Troops.get_child(i) as Node2D
			child.position=vector.rotated(deg2rad(value))
			value+=step
