extends Node2D
class_name StayingTroops

export var Tint:Color
onready var _Sprite:=$Sprite

func _ready()->void:
	_Sprite.self_modulate=Tint
