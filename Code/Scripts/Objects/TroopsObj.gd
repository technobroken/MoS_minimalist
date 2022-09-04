extends Reference
class_name TroopsObj

var _amounts:Dictionary#(troop_key,amount)

func has_troop(troop_key:String)->bool:
	return _amounts.has(troop_key)

func count_troop(troop_key:String)->int:
	return int(_amounts[troop_key])

func add_troop(troop_key:String)->void:
	_amounts[troop_key]+=1

func remove_troop(troop_key:String,amount:int)->void:
	_amounts[troop_key]-=amount

func zero(troop_key:String)->void:
	_amounts[troop_key]=0

func get_troop_keys()->Array:
	return _amounts.keys()

func get_defense_points()->float:
	return _get_points("defense")

func get_attack_points()->float:
	return _get_points("attack")

func _get_points(skill:String)->float:
	var total:=0.0
	for troop_key in _amounts:
		var amount:=int(_amounts[troop_key])
		var points:=int(Data.TROOPS[troop_key][skill])
		total+=points*amount
	return total

func defeat()->void:
	for troop_key in _amounts:
		_amounts[troop_key]=0

func apply_bajas(factor:float)->void:
	for troop_key in _amounts:
		_amounts[troop_key]=int(round(factor*int(_amounts[troop_key])))

func apply_altas(troops:TroopsObj)->void:
	for troop_key in troops._amounts:
		_amounts[troop_key]+=troops._amounts[troop_key]

func _init(troop_amounts:Dictionary)->void:
	_amounts=troop_amounts

func _to_string()->String:
	return str(_amounts)
