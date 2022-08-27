extends Control
class_name ActionPanel

signal sig_closed(action,params)

func close(action:int,params:={})->void:
	visible=false
	emit_signal("sig_closed",action,params)
