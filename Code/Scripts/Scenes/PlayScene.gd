extends Node
class_name PlayScene

onready var _TopBar:=$HUD/TopBar as TopBar
onready var _Menu:=$HUD/GamePlayPauseMenu as GamePlayPauseMenu
onready var _LevelContainer:=$LevelContainer as Node
onready var _Level:=$LevelContainer/Level00 as Level
onready var _PanelProduction:=$HUD/PanelProduction as PanelProduction
onready var _PanelTroops:=$HUD/PanelTroops as PanelTroops
onready var _PanelAttack:=$HUD/PanelAttack as PanelAttack
onready var _PanelReports:=$HUD/PanelReports as PanelBase
onready var _PanelEndGame:=$HUD/PanelEndGame as PanelEndGame
var _human_city_selected:HumanCity
var _npc_city_selected:NpcCity

func _ready()->void:
	$AudioStreamPlayer.playing=true
	_TopBar.connect("sig_menu_button_pressed",self,"_sig_menu_button_pressed")
	_TopBar.connect("sig_city_action",self,"_sig_city_action")
	_Menu.connect("sig_closed",self,"_sig_pause_menu_closed")
#	if not Globals._game.level_path.empty():
#		var level_prefab:=load(Globals._game.level_path) as PackedScene
#		_Level=level_prefab.instance()
#		_LevelContainer.add_child(_Level)
	_Level.connect("sig_city_selected",self,"_sig_city_selected")
	_Level.connect("sig_throw_attack",self,"_sig_throw_attack")
	_Level.connect("sig_attack_done",self,"_sig_attack_done")
	_Level.connect("sig_end_game",self,"_sig_end_game")
	_sig_city_selected(_Level.get_human_city())
	_PanelEndGame.connect("sig_closed",self,"sig_panel_endgame_closed")

func _sig_pause_menu_closed(action:int,params:={})->void:
	_Menu.hide()
	match action:
		GamePlayPauseMenu.Actions.Exit:
			_exit_game()

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
		TopBar.EActions.REPORTS_ACTION:
			_PanelReports.show()

func sig_panel_endgame_closed(action:int,params:={})->void:
	match action:
		PanelEndGame.ACTION_CLOSE_PANEL:
			_exit_game()

func _sig_attack_done()->void:
	_PanelTroops.refresh()
	_PanelAttack.refresh()

func _sig_end_game(is_human_winner:bool)->void:
	if is_human_winner:
		_PanelEndGame.EndGameText="You win"
	else:
		_PanelEndGame.EndGameText="You loose"
	_PanelEndGame.show()

func _exit_game()->void:
	match Globals._game.mode:
		Game.EMode.Campaing:
			get_tree().change_scene("res://Scenes/CampaingScene.tscn")
		_:
			get_tree().change_scene("res://Scenes/IntroScene.tscn")
