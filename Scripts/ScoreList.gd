extends Control


func _ready():
	print(Variables.scores[0])
	
	$VBoxContainer/RichTextLabel.text = ("level 1 "+str(int(Variables.scores[0])))
	$VBoxContainer/RichTextLabel2.text = ("level 2 "+str(int(Variables.scores[1])))
	
