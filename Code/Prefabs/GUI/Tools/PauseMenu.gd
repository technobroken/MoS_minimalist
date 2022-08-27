extends ActionPanel
class_name PauseMenu

export var ActionName:String

func show()->void:
	if not visible:
		_handle_pause()

func hide()->void:
	if visible:
		_handle_pause()

func _unhandled_input(event:InputEvent)->void:
	if event.is_action_pressed(ActionName):
		_handle_pause()

func _handle_pause()->void:
	visible=not visible
	get_tree().paused=visible
