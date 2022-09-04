extends ColorRect
class_name PanelReportsRow

const TROOP_COL_PREFAB=preload("res://Prefabs/GUI/PanelReportsTroopCol.tscn")
#export var attack_tribe_key:String="T1"
#export var defense_tribe_key:String="T1"
onready var _Date:=$VBoxContainer/Label as Label
onready var _Attack:=$VBoxContainer/AttackRect/MarginContainer/Attack as Control
onready var _Defense:=$VBoxContainer/DefenseRect/MarginContainer/Defense as Control
var attack_report:AttackReportObj

func _ready()->void:
	if attack_report!=null:
		var before_attack_troops_obj:=attack_report.ofensive_before
		var after_attack_troops_obj:=attack_report.ofensive_after
		var before_defense_troops_obj:=attack_report.defense_before
		var after_defense_troops_obj:=attack_report.defense_after
		var attack_tribe_key:=attack_report.ofensive_tribe_key
		var defense_tribe_key:=attack_report.defense_tribe_key
		_fill_date()
		_add_cols(attack_tribe_key,before_attack_troops_obj,after_attack_troops_obj,_Attack)
		_add_cols(defense_tribe_key,before_defense_troops_obj,after_defense_troops_obj,_Defense)

func _fill_date()->void:
	var date:=OS.get_datetime()
	_Date.text="%02d:%02d:%02d"%[date.hour,date.minute,date.second]

static func _add_cols(tribe_key:String,before_troops_obj:TroopsObj,after_troops_obj:TroopsObj,container:Control)->void:
	var troop_keys:=Data.TRIBES[tribe_key]["troops"] as Array
	for troop_key in troop_keys:
		var col:=TROOP_COL_PREFAB.instance() as PanelReportsTroopCol
		col.TroopTexture=Data.TROOPS[troop_key]["texture"]
		if before_troops_obj.has_troop(troop_key):
			col.AmountBefore=before_troops_obj.count_troop(troop_key)
		else:
			col.AmountBefore=0
		if after_troops_obj.has_troop(troop_key):
			col.AmountAfter=after_troops_obj.count_troop(troop_key)
		else:
			col.AmountAfter=0
		container.add_child(col)
