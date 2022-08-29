extends PanelBase
class_name PanelEndGame

export var EndGameText:String
onready var _Label:=$CenterContainer/VBoxContainer/Center/CenterContainer/Label

func _ready()->void:
	pass

func _on_PanelEndGame_visibility_changed()->void:
	if visible:
		_Label.text=EndGameText
