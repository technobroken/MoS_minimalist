extends HBoxContainer
class_name PanelTroopsRow

signal sig_add_troop()
export var TroopKey:String
export var Amount:int
onready var _Amount:=$VBoxContainer/Amount/Label as Label

func set_amount(amount:int)->void:
	Amount=amount
	_Amount.text=str(Amount)

func inc_amount()->void:
	Amount+=1
	_Amount.text=str(Amount)

func _ready()->void:
	_Amount.text=str(Amount)

func _on_PlusButton_pressed()->void:
	emit_signal("sig_add_troop")
