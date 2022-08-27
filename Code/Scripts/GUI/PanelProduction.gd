extends PanelBase
class_name PanelProduction

onready var _ProductionButtons:=$CenterContainer/VBoxContainer/Center/CenterContainer/ProductionButtons as Control
var _city_obj:CityObj

func set_city(city_obj:CityObj)->void:
	_city_obj=city_obj
	for i in _ProductionButtons.get_child_count():
		var button:=_ProductionButtons.get_child(i) as PanelProductionRow
		var production=_city_obj._raw_materials_production[button.RawMaterial]
		button.set_active(production>0)

func _ready()->void:
	$CenterContainer/VBoxContainer/Top/MarginContainer/HBoxContainer/Title.text="Granjas"
	$CenterContainer/VBoxContainer.rect_min_size.y=400
	for i in _ProductionButtons.get_child_count():
		var button:=_ProductionButtons.get_child(i) as PanelProductionRow
		button.connect("sig_toggled",self,"_on_button_toggled",[button.RawMaterial])

func _on_button_toggled(button_pressed:bool,raw_material_index:int)->void:
	_city_obj.change_production(not button_pressed,raw_material_index)
