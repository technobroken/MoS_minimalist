extends Reference
class_name CityObj

const PRODUCTION:=20
var _tmp_prod:=[1,1,1,1]
var tribe_data:Dictionary
var _troops:TroopsObj
var _raw_materials:RawMaterials
var _raw_materials_production:Array

func change_production(flag:bool,raw_material_index:int)->void:
	_raw_materials_production[raw_material_index]=0 if flag else 1
	var count:=4
	for p in _raw_materials_production:
		if p==0: count-=1
	var f:=0 if count==0 else 4/count
	for i in _raw_materials_production.size():
		if _raw_materials_production[i]!=0:
			_raw_materials_production[i]=1*f

func produce_materials()->void:
	for i in _tmp_prod.size():
		_raw_materials._amounts[i]+=PRODUCTION*_raw_materials_production[i]

func try_add_troop(troop_key:String,troop_data:Dictionary)->bool:
	var cost:=troop_data["cost"] as Array
	if _raw_materials.has_enough(cost):
		_raw_materials.consume(cost)
		_troops.add_troop(troop_key)
		return true
	return false

func _init(tribe_data:Dictionary)->void:
	self.tribe_data=tribe_data
	var troop_amounts:={}
	for troop_key in tribe_data["troops"]:
		troop_amounts[troop_key]=0
	_troops=TroopsObj.new(troop_amounts)
	_raw_materials=RawMaterials.new([100,100,100,100])
	_raw_materials_production=[1,1,1,1]
