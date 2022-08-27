extends Reference
class_name RawMaterials

var _amounts:Array

func get_material(index:int)->float:
	return _amounts[index]

func has_enough(cost:Array)->bool:
	for i in _amounts.size():
		if _amounts[i]-cost[i]<0:
			return false
	return true

func consume(cost:Array)->void:
	for i in _amounts.size():
		_amounts[i]-=cost[i]

func _init(amounts:Array)->void:
	_amounts=amounts
