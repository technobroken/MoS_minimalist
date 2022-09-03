extends CanvasLayer

export var FadeInTime:float=1.0
export var FadeOutTime:float=1.0
onready var _TweenFader:=$TweenFader as Tween
onready var _ColorRect:=$ColorRect as ColorRect

func change_scene(scene_path:NodePath)->void:
	_change_scene_with_tween(scene_path,FadeOutTime,FadeInTime)

func _ready()->void:
	_ColorRect.hide()

func _change_scene_with_tween(scene_path:NodePath,fade_out_time:float,fade_in_time:float)->void:
	#get_tree().get_root().set_disable_input(true)
	get_tree().paused=true
	_ColorRect.show()
	yield(_fade_out(fade_out_time,_ColorRect,_TweenFader),"completed")
	assert(OK==get_tree().change_scene(scene_path))
	yield(_fade_in(fade_in_time,_ColorRect,_TweenFader),"completed")
	_ColorRect.hide()
	get_tree().paused=false
	#get_tree().get_root().set_disable_input(false)

static func _fade_out(time:float,color_rect:ColorRect,tween:Tween)->void:
	yield(_fade_colorRect(0.0,1.0,time,color_rect,tween),"completed")

static func _fade_in(time:float,color_rect:ColorRect,tween:Tween)->void:
	yield(_fade_colorRect(1.0,0.0,time,color_rect,tween),"completed")

static func _fade_colorRect(alpha_in:float,alpha_out:float,time:float,color_rect:ColorRect,tween:Tween)->void:
	#assert(true==tween.stop_all())
	assert(true==tween.interpolate_property(color_rect,"modulate:a",alpha_in,alpha_out,time,Tween.TRANS_LINEAR,Tween.EASE_IN))
	assert(true==tween.start())
	yield(tween,"tween_completed")
