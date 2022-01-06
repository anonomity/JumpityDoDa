extends KinematicBody2D

var velocity = Vector2()
var direction = -1
func _ready():
	pass

func _physics_process(delta):
	velocity.y += 20
	
	if direction == -1:
		$AnimatedSprite.flip_h = false
		velocity.x = -50
	elif direction == 1:
		$AnimatedSprite.flip_h = true
		velocity.x= 50
	move_and_slide(velocity)
