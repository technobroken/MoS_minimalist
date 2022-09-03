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

func _ready()->void:
	_game=Game.new()
