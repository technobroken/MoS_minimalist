extends Node

const LEVEL:={
	"players":[
		{"name":"josele","type":"HUMAN"},
		{"name":"te pego","type":"NPC"},
	],
	"cities":[
		{"player_index":0,"position":{"x":10,"y":10}},
		{"player_index":1,"position":{"x":100,"y":100}}
	]
}
var _game:Game
var ev_listeners:={}

func _ready()->void:
	_game=Game.new()
	ev_listeners["EVENT_TROOPS_IN_CITY"]=EvListener.new()
