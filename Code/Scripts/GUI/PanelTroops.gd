extends PanelBase
class_name PanelTroops

const PANEL_TROOP_ROW_PREFAB:=preload("res://Prefabs/GUI/PanelTroopsRow.tscn")
onready var _TroopRows:=$CenterContainer/VBoxContainer/Center/CenterContainer/TroopRows
var _city:City

func set_city(city:City)->void:
	if _city!=city:
		_city=city
		NodeTools.free_children(_TroopRows)
		var troop_keys:=_city._city_obj.tribe_data["troops"] as Array
		for i in troop_keys.size():
			var row:=PANEL_TROOP_ROW_PREFAB.instance() as PanelTroopsRow
			row.TroopKey=troop_keys[i]
			_TroopRows.add_child(row)
			row.connect("sig_add_troop",self,"_sig_add_troop",[i,troop_keys[i]])

func refresh()->void:
	if visible:_refresh()

func _ready()->void:
	$CenterContainer/VBoxContainer.rect_min_size.y=400

func _sig_add_troop(row_index:int,troop_key:String)->void:
	var is_added:=_city.try_add_troop(troop_key)
	if is_added:
		var row:=_TroopRows.get_child(row_index) as PanelTroopsRow
		row.inc_amount()

func _on_PanelTroops_visibility_changed()->void:
	if visible:
		_refresh()

func _refresh()->void:
	for i in _TroopRows.get_child_count():
		var row:=_TroopRows.get_child(i) as PanelTroopsRow
		var amount:=_city._city_obj._troops.count_troop(row.TroopKey)
		row.set_amount(amount)
