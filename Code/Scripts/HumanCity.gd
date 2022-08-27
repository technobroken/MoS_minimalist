extends City
class_name HumanCity

func _ready()->void:
	_city_obj=HumanCityObj.new(Data.TRIBES[TribeKey])
