extends Reference
class_name CombatSimulator

static func simulate_combat(attack_troops_obj:TroopsObj,defense_troops_obj:TroopsObj)->void:
	#calcular ofensiva
	var attack:=attack_troops_obj.get_attack_points()
	#calcular defensa
	var defense:=defense_troops_obj.get_defense_points()
	#comparar resultados
	var diference:=attack-defense
	if diference>0:
		#defensa no ha soportado el ataque
		defense_troops_obj.defeat()
		#calular las bajas en el ataque
		var factor:=abs(diference)/attack
		attack_troops_obj.apply_bajas(factor)
	else:
		#defensa ha soportado el ataque->todas las tropas de ataque mueren
		attack_troops_obj.defeat()
		#calular las bajas en la defensa
		var factor:=abs(diference)/defense
		defense_troops_obj.apply_bajas(factor)
