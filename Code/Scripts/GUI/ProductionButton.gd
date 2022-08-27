extends HBoxContainer
class_name ProductionButton

signal sig_pressed()
export (Enums.ERawMaterials) var RawMaterial

func _ready()->void:
	pass # Replace with function body.

func _on_CheckButton_pressed()->void:
	emit_signal("sig_pressed")
