extends Level
class_name Level00

onready var _HumanCity:=$Cities/HumanCity as HumanCity
onready var _NpcCity:=$Cities/NpcCity as NpcCity

func _ready()->void:
	_NpcCity.set_target_city(_HumanCity)
