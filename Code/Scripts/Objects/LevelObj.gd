extends Reference
class_name LevelObj

var cities:Array

func _init(info:Dictionary)->void:
	for city in info["cities"]:
		var city_level:=PrvCityLevel.new(city)
		cities.append(city_level)

class PrvCityLevel:
	var player_index:int
	var position:Vector2
	func _init(info:Dictionary)->void:
		player_index=info["player_index"]
		position=Vector2(info["position"]["x"],info["position"]["y"])
