extends CanvasLayer
class_name CampaingScene

const LEVELS:=[
	"res://Prefabs/Levels/Level00.tscn"
]
onready var _StageButtons:=$StateButtons as Node

func _ready()->void:
	Globals._game.mode=Game.EMode.Campaing
	for i in _StageButtons.get_child_count():
		var button:=_StageButtons.get_child(i) as TextureButton
		button.connect("pressed",self,"_stage_pressed",[i])

func _stage_pressed(stage_index:int)->void:
	if stage_index<LEVELS.size():
		Globals._game.level_path=LEVELS[stage_index]
	get_tree().change_scene("res://Scenes/PlayScene.tscn")

func _on_ExitButton_pressed()->void:
	get_tree().change_scene("res://Scenes/IntroScene.tscn")
