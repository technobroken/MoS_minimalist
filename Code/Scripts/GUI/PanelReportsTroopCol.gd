extends VBoxContainer
class_name PanelReportsTroopCol

export var AmountBefore:int
export var AmountAfter:int
export var TroopTexture:Texture
onready var _Texture:=$TextureRect as TextureRect
onready var _AmountBefore:=$AmountBefore as Label
onready var _AmountAfter:=$AmountAfter as Label

func _ready()->void:
	_Texture.texture=TroopTexture
	_AmountAfter.text=str(AmountAfter)
	_AmountBefore.text=str(AmountBefore)
