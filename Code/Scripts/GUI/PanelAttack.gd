extends PanelBase
class_name PanelAttack

signal sig_throw_attack()
const ROW_PREFAB:=preload("res://Prefabs/GUI/PanelAttackTroopRow.tscn")
onready var _Rows:=$CenterContainer/VBoxContainer/Center/CenterContainer/HBoxContainer/TroopRows as Control
var _source_city:City
var _target_city:City
var _source_city_obj:CityObj
var _target_city_obj:CityObj
var _row_seleted:PanelAttackTroopRow

func set_cities(source_city:City,target_city:City)->void:
	_source_city=source_city
	_target_city=target_city
	_source_city_obj=source_city._city_obj
	_target_city_obj=target_city._city_obj
	var troop_keys:=_source_city_obj.tribe_data["troops"] as Array
	for i in troop_keys.size():
		var row:=ROW_PREFAB.instance() as PanelAttackTroopRow
		_Rows.add_child(row)
		row.TroopKey=troop_keys[i]
		row.connect("sig_pressed",self,"_sig_row_selected")

func _ready()->void:
	_row_seleted=null

func _sig_row_selected(row_selected:PanelAttackTroopRow)->void:
	if _row_seleted!=row_selected:
		_row_seleted=row_selected
		for i in _Rows.get_child_count():
			var row:=_Rows.get_child(i) as PanelAttackTroopRow
			if row!=row_selected:
				row.set_selected(false)

func _on_PanelAttack_visibility_changed()->void:
	if visible:
		_row_seleted=null
		for i in _Rows.get_child_count():
			var row:=_Rows.get_child(i) as PanelAttackTroopRow
			var total:=_source_city_obj._troops.count_troop(row.TroopKey)
			row.set_total(total)

func _on_ButtonPlus_pressed()->void:
	if _row_seleted!=null:
		var total:=_row_seleted.get_total()
		_row_seleted.inc_amount()

func _on_AttackButton_pressed()->void:
	var troop_amounts:={}
	for i in _Rows.get_child_count():
		var row:=_Rows.get_child(i) as PanelAttackTroopRow
		var troop_key:=row.TroopKey
		var amount:=row.get_amount()
		troop_amounts[troop_key]=amount
		_source_city.remove_troops(row.TroopKey,amount)
	.close(PanelBase.ACTION_CLOSE_PANEL)
	var troops:=TroopsObj.new(troop_amounts)
	emit_signal("sig_throw_attack",troops)
