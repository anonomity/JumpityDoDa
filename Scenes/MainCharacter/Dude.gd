extends KinematicBody2D

var velocity = Vector2 (0,0)
const SPEED = 250
const JUMPFORCE = -750

const GRAVITY = 2200
const DASHFORCE = 5000
const DASHJUMP = -900
var regen_dash = true




func _physics_process(_delta):
	
	if Input.is_action_pressed("left"):
		$AnimatedSprite.flip_h = true
		velocity.x = -SPEED
		if is_on_floor():
			$AnimatedSprite.play("run")
			
		
	elif Input.is_action_pressed("right"):
		
		velocity.x = SPEED
		$AnimatedSprite.flip_h = false
		if is_on_floor():
			$AnimatedSprite.play("run")
	elif is_on_floor():
		$AnimatedSprite.play("idle")
	
	if is_on_wall() and Input.is_action_pressed("climb"):
		$AnimatedSprite.play("climb")
		velocity.x += GRAVITY * _delta
	else:
		velocity.y += GRAVITY * _delta
		
	if Input.is_action_pressed("dash") and Input.is_action_pressed("left") and regen_dash:
		$AnimatedSprite.play("dash")
		regen_dash= false
		velocity.x = -DASHFORCE
	if Input.is_action_pressed("dash") and Input.is_action_pressed("right") and regen_dash:
		$AnimatedSprite.flip_h = false
		regen_dash= false
		$AnimatedSprite.play("dash")
		velocity.x = DASHFORCE
	if Input.is_action_pressed("dash") and Input.is_action_pressed("up") and regen_dash: 
		$AnimatedSprite.play("dashup")
		regen_dash= false
		velocity.y = DASHJUMP
	if Input.is_action_pressed("up") and is_on_floor() :
		$AnimatedSprite.play("jump")
		velocity.y = JUMPFORCE
		
	if is_on_floor():
		regen_dash= true
	
		
	
	velocity = move_and_slide(velocity, Vector2.UP)
	velocity.x = lerp(velocity.x, 0, 0.1)
	
	
	
	
	
	




func _on_Area2D_body_entered(body):

	get_tree().change_scene("res://Scenes/Level1.tscn")
