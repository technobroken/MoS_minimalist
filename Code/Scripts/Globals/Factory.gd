extends Node

static func TroopsObj_create_from_keys(troop_keys:Array)->TroopsObj:
	var troop_amounts:={}
	for troop_key in troop_keys:
		troop_amounts[troop_key]=0
	return TroopsObj.new(troop_amounts)

func _ready()->void:
	pass # Replace with function body.

