extends TextureRect
class_name TopBarResource

export (Enums.ERawMaterials)var RawMaterial
onready var _Label:=$MarginContainer/HBoxContainer/Label

func set_amount(amount:float)->void:
	_Label.text=str(int(amount))
