extends Node2D
class_name Level

signal sig_city_selected()
const HUMAN_CITY_PREFAB:=preload("res://Prefabs/HumanCity.tscn")
const NPC_CITY_PREFAB:=preload("res://Prefabs/NpcCity.tscn")
export var HumanCityIndex:int
onready var _CitiesContainer:=$Cities as Node
var _human_city:City

func get_human_city()->City:
	return _human_city

func _ready()->void:
	#_load_level(Globals.LEVEL,_CitiesContainer,self)
	for i in _CitiesContainer.get_child_count():
		var city:=_CitiesContainer.get_child(i) as City
		city.connect("sig_pressed",self,"_sig_city_selected")
		if HumanCityIndex==i:
			_human_city=city

func _sig_city_selected(city:City)->void:
	emit_signal("sig_city_selected",city)

#static func _load_level(level_info:Dictionary,cities_container:Node,signal_listner:Node)->void:
#	var cities_info:=level_info.cities as Array
#	for c in cities_info:
#		var player_type:=level_info.players[c.player_index].type as String
#		var city:City
#		match player_type:
#			"HUMAN":
#				city=HUMAN_CITY_PREFAB.instance()
#			"NPC":
#				city=NPC_CITY_PREFAB.instance()
#		cities_container.add_child(city)
#		city.position.x=c.position.x
#		city.position.y=c.position.y
#		city.connect("sig_pressed",signal_listner,"_sig_city_selected")
