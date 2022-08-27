extends HBoxContainer
class_name PanelProductionRow

signal sig_toggled()
export (Enums.ERawMaterials) var RawMaterial
onready var _Check:=$CheckButton as CheckButton

func set_active(flag:bool)->void:
	_Check.pressed=flag

func is_active()->bool:
	return _Check.pressed

func _ready()->void:
	pass # Replace with function body.

func _on_CheckButton_toggled(button_pressed:bool)->void:
	emit_signal("sig_toggled",button_pressed)
