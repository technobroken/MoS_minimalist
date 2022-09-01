extends Reference
class_name Data

const TROOPS:={
	"T1":{"attack":100,"defense":50,"cost":[100,100,100,100],"texture":preload("res://Assets/Textures/Tribe1Troop1.png")},
	"T2":{"attack":50,"defense":100,"cost":[100,100,100,100],"texture":preload("res://Assets/Textures/Tribe1Troop2.png")}
}
const TRIBES:={
	"T1":{"troops":["T1","T2"]},
	"T2":{}
}
