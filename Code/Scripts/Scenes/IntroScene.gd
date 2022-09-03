extends Node
class_name IntroScene

func _ready()->void:
	pass # Replace with function body.

func _on_CampaingButton_pressed()->void:
	SceneTransitor.change_scene("res://Scenes/CampaingScene.tscn")
#	get_tree().change_scene("res://Scenes/CampaingScene.tscn")

func _on_BattleButton_pressed()->void:
	pass # Replace with function body.

func _on_QuitButton_pressed()->void:
	get_tree().quit()
