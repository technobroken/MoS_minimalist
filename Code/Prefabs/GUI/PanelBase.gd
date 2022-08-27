extends ActionPanel
class_name PanelBase

const ACTION_CLOSE_PANEL:=0

func _on_CloseButton_pressed()->void:
	.close(ACTION_CLOSE_PANEL)
