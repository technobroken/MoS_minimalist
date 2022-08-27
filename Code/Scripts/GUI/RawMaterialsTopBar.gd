extends HBoxContainer
class_name RawMaterialsTopBar

func set_materials(raw_materials:RawMaterials)->void:
	for i in get_child_count():
		var child:=get_child(i) as TopBarResource
		var amount:=raw_materials.get_material(child.RawMaterial)
		child.set_amount(amount)
