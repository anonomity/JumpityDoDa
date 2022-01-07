extends StaticBody2D

var in_trigger = false
var win = false
func _ready():
	in_trigger = false
	print(in_trigger)
	win = false
	$AnimatedSprite.play("idle")

func _physics_process(delta):
	if(in_trigger):

		if(Input.is_action_just_pressed("interact")):
			win = true
			$AnimatedSprite.play("flip")
			

func get_in_trigger():
	return in_trigger

func _on_Area2D_body_entered(body):
	print("setting trigger to true ", body)
	in_trigger = true

func _on_Area2D_body_exited(body):
	in_trigger = false

func _on_AnimatedSprite_animation_finished():
	if(win):
		Variables.add_score()
		
		if(Variables.currentLevel == 1):
			Variables.currentLevel += 1
			get_tree().change_scene("res://Scenes/Level22.tscn")
		elif(Variables.currentLevel == 2):
			Variables.currentLevel += 1
			get_tree().change_scene("res://Scenes/ScoreList.tscn")
		
		$AnimatedSprite.play("idle")
		win = false
	
	
	
