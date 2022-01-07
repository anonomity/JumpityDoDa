extends Node


onready var currentTime = 0
onready var scores = []
onready var score = 0
onready var currentLevel = 1


func _ready():
	print("score" , currentTime)


func inc_score(var amount : int):
	score += amount

func add_score():
	convert_time_to_score()
	scores.push_back(score)

	
	currentTime = 0
	score = 0
	
func convert_time_to_score():
	var new_score  = 1000 - currentTime
	score = new_score + score



	
	
