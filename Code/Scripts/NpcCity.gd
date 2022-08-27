extends City
class_name NpcCity

func _ready()->void:
	_city_obj=NpcCityObj.new(Data.TRIBES[TribeKey])
