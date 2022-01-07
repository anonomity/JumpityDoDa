extends Node2D

onready var timer = get_node("Timer")
var DisplayValue = 0

var score = 0


func _process(delta):
	DisplayValue += delta 
	var t = int(DisplayValue)
	Variables.currentTime = DisplayValue
	$CanvasLayer/Timer.text = ("Timer: "+ str(t))
	$CanvasLayer/score.text = ("Score: " + str(Variables.score))


	
