extends VBoxContainer
class_name PanelTroopsRow

signal sig_add_troop()
export var TroopKey:String
export var Amount:int
onready var _Troop:=$TroopsRow/TextureButton/TextureRect as TextureRect
onready var _Amount:=$TroopsRow/VBoxContainer/Amount/Label as Label
onready var _Skills:=$Skills as Label

func set_amount(amount:int)->void:
	Amount=amount
	_Amount.text=str(Amount)

func inc_amount()->void:
	Amount+=1
	_Amount.text=str(Amount)

func _ready()->void:
	var attack:=Data.TROOPS[TroopKey]["attack"] as int
	var defense:=Data.TROOPS[TroopKey]["defense"] as int
	_Troop.texture=Data.TROOPS[TroopKey]["texture"]
	_Amount.text=str(Amount)
	_Skills.text="Attack:%d - Defense:%d"%[attack,defense]

func _on_PlusButton_pressed()->void:
	emit_signal("sig_add_troop")
