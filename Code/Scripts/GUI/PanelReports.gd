extends PanelBase
class_name PanelReports

const ROW_PREFAB:=preload("res://Prefabs/GUI/PanelReportsRow.tscn")
onready var _Reports:=$CenterContainer/VBoxContainer/Center/ScrollContainer/MarginContainer/Reports
var _rows:Array

func add_report(attack_report:AttackReportObj)->void:
	var row:=ROW_PREFAB.instance() as PanelReportsRow
	row.attack_report=attack_report
	_Reports.add_child(row)
	_Reports.move_child(row,0)

func _ready()->void:
	pass # Replace with function body.

func _on_PanelReports_visibility_changed()->void:
	if visible:
		for report_row in _rows:
			pass
