extends Node2D
class_name Level

signal sig_city_selected()
signal sig_throw_attack()
signal sig_attack_done()
signal sig_end_game()
const HUMAN_CITY_PREFAB:=preload("res://Prefabs/HumanCity.tscn")
const NPC_CITY_PREFAB:=preload("res://Prefabs/NpcCity.tscn")
const HUMAN_ATTACK_PREFAB:=preload("res://Prefabs/HumanTravelingTroops.tscn")
const NPC_ATTACK_PREFAB:=preload("res://Prefabs/NpcTravelingTroops.tscn")
export var HumanCityIndex:int
export var NpcCityIndex:int
onready var _CitiesContainer:=$Cities as Node
var _human_city:City
var _npc_city:City

func get_human_city()->City:
	return _human_city

func _ready()->void:
	#_load_level(Globals.LEVEL,_CitiesContainer,self)
	for i in _CitiesContainer.get_child_count():
		var city:=_CitiesContainer.get_child(i) as City
		city.connect("sig_pressed",self,"_sig_city_selected")
		city.connect("sig_throw_attack",self,"_sig_throw_attack")
		city.connect("sig_defeated",self,"_sig_defeated")
		if city is HumanCity:
			_human_city=city
		elif city is NpcCity:
			_npc_city=city

func _sig_city_selected(city:City)->void:
	emit_signal("sig_city_selected",city)

func _sig_throw_attack(source_city:City,target_city:City,troops_obj:TroopsObj)->void:
	var attack:TravelingTroops
	if source_city is HumanCity:
		attack=HUMAN_ATTACK_PREFAB.instance() as TravelingTroops
	elif source_city is NpcCity:
		attack=NPC_ATTACK_PREFAB.instance() as TravelingTroops
	attack.init(source_city,target_city,troops_obj)
	add_child(attack)
	attack.connect("sig_attack_done",self,"_sig_attack_done")

func _sig_attack_done()->void:
	emit_signal("sig_attack_done")

func _sig_defeated(city:City)->void:
	for i in _CitiesContainer.get_child_count():
		var city_i:=_CitiesContainer.get_child(i) as City
		city_i._active=false
	var is_human_winner:=city!=_human_city
	emit_signal("sig_end_game",is_human_winner)

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
