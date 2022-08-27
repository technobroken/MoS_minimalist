extends PauseMenu
class_name GamePlayPauseMenu

enum Actions{Resume,Save,Exit}

func _ready()->void:
	pass # Replace with function body.

func _on_ResumeButton_pressed()->void:
	close(Actions.Resume)

func _on_SaveButton_pressed()->void:
	close(Actions.Save)

func _on_ExitButton_pressed()->void:
	close(Actions.Exit)
