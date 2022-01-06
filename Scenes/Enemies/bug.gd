extends KinematicBody2D

var velocity = Vector2()
var direction = -1
func _ready():
	if direction == 1:
		$AnimatedSprite.flip_h = true
	print($CollisionShape2D.shape.get_extents().x)
	$floor_checker.position.x = $CollisionShape2D.shape.get_extents().x * direction

func _physics_process(delta):
	
	if is_on_wall() or not $floor_checker.is_colliding() and is_on_floor():
		
		direction = direction*-1
		$AnimatedSprite.flip_h = not $AnimatedSprite.flip_h
		$floor_checker.position.x = $CollisionShape2D.shape.get_extents().x * direction
	velocity.y += 20
	
	if direction == -1:
		$AnimatedSprite.flip_h = false
		velocity.x = -50
	elif direction == 1:
		$AnimatedSprite.flip_h = true
		velocity.x= 50
		
	velocity = move_and_slide(velocity, Vector2.UP)


func _on_top_checker_body_entered(body):
	
	if body.dash_time != 0:
		queue_free()
	else:
		get_tree().change_scene("res://Scenes/Level1.tscn")
	
