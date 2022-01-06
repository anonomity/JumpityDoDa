extends KinematicBody2D
# Player (Dude)


const GRAVITY := 2200.0
const SPEED := 250.0
const JUMPFORCE := -750.0
const DASHFORCE := 2000.0
const DASHJUMP := -800.0
const MAX_DASH_TIME := 0.1				# Dash time


var jumpwall = 600
var walljump	 = 1000
var wall_jump_cooldown = 0

var gravity := GRAVITY
var velocity := Vector2.ZERO
var move_direction := Vector2.ZERO
var dash_driection := Vector2.ZERO		# Can't do anything until it's ZERO
var can_dash := false					# Can't dash until true
var dash_time := 0.0					# Resets dash_direction to ZERO when dash time reaches MAX_DASH_TIME

onready var sprite := $AnimatedSprite as AnimatedSprite


func _physics_process(_delta: float) -> void:
	if dash_driection == Vector2.ZERO:
		input_direction()
		
		# Moving
		if move_direction.x == -1:
			sprite.flip_h = true
			velocity.x = -SPEED
			if is_on_floor():
				sprite.play("run")
			else:
				fall()
		elif move_direction.x == 1:
			velocity.x = SPEED
			sprite.flip_h = false
			if is_on_floor():
				sprite.play("run")
			else:
				fall()
		else:
			if is_on_floor():
				sprite.play("idle")
			else:
				fall()
		
		# Climbing
		if next_to_wall() and Input.is_action_pressed("climb"):
			
			sprite.play("climb")
			velocity.y = -SPEED
			gravity = 0
			if wall_jump_cooldown == 0:
				if not is_on_floor() and nextToRightWall() and Input.is_action_pressed("jump") and RightWallJumpOver():
					sprite.play("climb_over")
					print("jumping over")
					velocity.x -= walljump
					velocity.y -= jumpwall
				if not is_on_floor() and nextToLeftWall() and Input.is_action_pressed("jump") and LeftWallJumpOver():
					sprite.play("climb_over")
					velocity.x += walljump
					velocity.y -= jumpwall
					
		else:
			gravity = GRAVITY
			velocity.y += gravity * _delta
		
		# Jumping
		if Input.is_action_just_pressed("jump") and is_on_floor() and not next_to_wall():
			sprite.play("jump")
			velocity.y = JUMPFORCE
		# Variable jump
		if Input.is_action_just_released("jump") and velocity.y < 0:
			velocity.y = lerp(velocity.y, 0, 0.5)
	
	# Dashing
	if Input.is_action_just_pressed("dash") and can_dash and dash_time < MAX_DASH_TIME:
		velocity = Vector2.ZERO
		gravity = 0
		if move_direction.y == -1:
			dash_driection = Vector2.UP
		else:
			if sprite.flip_h:
				dash_driection = Vector2.LEFT
			else:
				dash_driection = Vector2.RIGHT
		
		can_dash = false
	
	# Dashing update
	if dash_driection != Vector2.ZERO:
		dash_time += _delta
		
		if dash_driection == Vector2.UP:
			# Vertical dashing
			sprite.play("dashup")
			velocity.y = DASHJUMP
		else:
			# Horizontal dashing
			sprite.play("dash")
			velocity.x = DASHFORCE * get_look_direction()
		
	if dash_time > MAX_DASH_TIME:
		dash_driection = Vector2.ZERO
		dash_time = 0
		
	if is_on_floor():
		can_dash = true
	
	# Update moving
	velocity = move_and_slide(velocity, Vector2.UP)
	velocity.x = lerp(velocity.x, 0, 0.5)

	

# Player input direction
func input_direction() -> void:
	move_direction.x = float(Input.is_action_pressed("right")) - float(Input.is_action_pressed("left"))
	move_direction.y = float(Input.is_action_pressed("down")) - float(Input.is_action_pressed("up"))

func next_to_wall():
	return nextToRightWall() or nextToLeftWall()

func nextToRightWall():
	return $RightWall.is_colliding()

func nextToLeftWall():
	return $LeftWall.is_colliding()

func RightWallJumpOver():
	return not $CanRightJumpOver.is_colliding()

func LeftWallJumpOver():
	return not $CanLeftJumpOver.is_colliding()

# Player look direction using the sprite flip
func get_look_direction() -> int:
		var look_direction := 1
		if sprite.flip_h:
			look_direction = -1
		return look_direction


# Fall animation (just using jump single frame 2)
func fall() -> void:
	if sprite.animation == "jump" or sprite.animation == "climb":
		return
		
	sprite.animation = "jump"
	sprite.frame = 2


# On fall death, reset the level
func _on_Reset_body_entered(_body: Node) -> void:
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/Level1.tscn")

