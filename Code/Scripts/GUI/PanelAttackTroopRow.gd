extends ColorRect
class_name PanelAttackTroopRow

signal sig_pressed()
const SELECTED_COLOR:=Color('#2a2a2a')
const NORMAL_COLOR:=Color('#00000000')
export var TroopKey:String
onready var _Total:=$MarginContainer/HBoxContainer/VBoxContainer/Total as Label
onready var _Amount:=$MarginContainer/HBoxContainer/VBoxContainer/Amount as Label
var pressed:bool
var _total:int
var _amount:int

func set_total(total:int)->void:
	_total=total
	_Total.text=str(_total)

func get_total()->int:
	return _total

func inc_amount()->void:
	if _amount<_total:
		_amount+=1
		_Amount.text=str(_amount)

func dec_amount()->void:
	if _amount>1:
		_amount-=1
		_Amount.text=str(_amount)

func reset_amount()->void:
	_amount=0
	_Amount.text=str(_amount)

func get_amount()->int:
	return _amount

func set_selected(flag:bool)->void:
	pressed=flag
	color=SELECTED_COLOR if pressed else NORMAL_COLOR

func _ready()->void:
	color=NORMAL_COLOR
	pressed=false
	_total=0
	_amount=0

func _on_TextureButton_toggled(button_pressed:bool)->void:
	color=SELECTED_COLOR if button_pressed else NORMAL_COLOR
	emit_signal("sig_pressed",self)
