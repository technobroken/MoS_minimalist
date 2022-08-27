extends Node
class_name PlayScene

const HUMAN_ATTACK_PREFAB:=preload("res://Prefabs/HumanTravelingTroops.tscn")
const NPC_ATTACK_PREFAB:=preload("res://Prefabs/NpcTravelingTroops.tscn")
onready var _TopBar:=$HUD/TopBar as TopBar
onready var _Menu:=$HUD/GamePlayPauseMenu as GamePlayPauseMenu
onready var _LevelContainer:=$LevelContainer as Node
onready var _Level:=$LevelContainer/Level00 as Level
onready var _PanelProduction:=$HUD/PanelProduction as PanelProduction
onready var _PanelTroops:=$HUD/PanelTroops as PanelTroops
onready var _PanelAttack:=$HUD/PanelAttack as PanelAttack
var _human_city_selected:HumanCity
var _npc_city_selected:NpcCity

func _ready()->void:
	_TopBar.connect("sig_menu_button_pressed",self,"_sig_menu_button_pressed")
	_TopBar.connect("sig_city_action",self,"_sig_city_action")
	_PanelAttack.connect("sig_throw_attack",self,"_sig_throw_attack")
	_Menu.connect("sig_closed",self,"_sig_pause_menu_closed")
#	if not Globals._game.level_path.empty():
#		var level_prefab:=load(Globals._game.level_path) as PackedScene
#		_Level=level_prefab.instance()
#		_LevelContainer.add_child(_Level)
	_Level.connect("sig_city_selected",self,"_sig_city_selected")
	_sig_city_selected(_Level.get_human_city())

func _sig_pause_menu_closed(action:int,params:={})->void:
	_Menu.hide()
	match action:
		GamePlayPauseMenu.Actions.Exit:
			match Globals._game.mode:
				Game.EMode.Campaing:
					get_tree().change_scene("res://Scenes/CampaingScene.tscn")
				_:
					get_tree().change_scene("res://Scenes/IntroScene.tscn")

func _sig_menu_button_pressed()->void:
	_Menu.show()

func _sig_city_selected(city:City)->void:
	var city_obj:=city._city_obj
	_TopBar.set_city(city_obj)
	if city_obj is NpcCityObj:
		_npc_city_selected=city
		_PanelAttack.set_cities(_human_city_selected,city)
	else:
		_human_city_selected=city
		_PanelProduction.set_city(city_obj)
		_PanelTroops.set_city(city)

func _sig_city_action(action:int)->void:
	match action:
		TopBar.EActions.PRODUCTION_CITY_ACTION:
			_PanelProduction.show()
		TopBar.EActions.TROOPS_CITY_ACTION:
			_PanelTroops.show()
		TopBar.EActions.ATTACK_CITY_ACTION:
			_PanelAttack.show()

func _sig_throw_attack(troops_obj:TroopsObj)->void:
	var attack:=HUMAN_ATTACK_PREFAB.instance() as TravelingTroops
	attack.init(_human_city_selected,_npc_city_selected,troops_obj)
	_LevelContainer.add_child(attack)
