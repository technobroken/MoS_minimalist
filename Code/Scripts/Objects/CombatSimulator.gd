extends Reference
class_name CombatSimulator

static func simulate_combat(attack_troops_obj:TroopsObj,target_city:City)->AttackReportObj:
	var attack_report:=AttackReportObj.new()
	var defense_troops_obj:=target_city._city_obj._troops
	attack_report.ofensive_before=TroopsObj.new(attack_troops_obj._amounts.duplicate(true))
	attack_report.defense_before=TroopsObj.new(defense_troops_obj._amounts.duplicate(true))
	#calcular ofensiva
	var attack:=attack_troops_obj.get_attack_points()
	#calcular defensa
	var defense:=defense_troops_obj.get_defense_points()
	#comparar resultados
	var diference:=attack-defense
	if diference>0:
		#atacantes ganan
		target_city.apply_troops_damage(0)
		#calular los sobrevivientes
		var factor:=abs(diference)/attack
		attack_troops_obj.apply_bajas(factor)
		#aplicar el daño en la ciudad target
		target_city.apply_city_damage(attack_troops_obj.get_attack_points())
	else:
		#defensores ganan
		attack_troops_obj.defeat()
		#calular las bajas en la defensa
		var factor:=0.0 if defense==0 else abs(diference)/defense
		target_city.apply_troops_damage(factor)
	attack_report.ofensive_after=TroopsObj.new(attack_troops_obj._amounts.duplicate(true))
	attack_report.defense_after=TroopsObj.new(defense_troops_obj._amounts.duplicate(true))
	return attack_report
