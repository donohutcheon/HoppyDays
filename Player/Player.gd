extends KinematicBody2D

var motion = Vector2(0, 0);
const SPEED = 1200;
const GRAVITY = 150;
const UP = Vector2(0, -1)
const JUMP_SPEED = 3100;
const BOOST_MULTIPLIER = 2;
const WORLD_LIMIT = 6000

var lives = 3

signal animate

func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	apply_gravity()
	jump()
	move()
	animate()

func jump():
	if Input.is_action_pressed("Jump") and is_on_floor():
		motion.y -= JUMP_SPEED;
		$JumpSFX.play()

func move():	
	if Input.is_action_pressed("Left"): # and !Input.is_action_pressed("Right"):
		motion.x = -SPEED;
	elif Input.is_action_pressed("Right"): # and !Input.is_action_pressed("Left"):
		motion.x = SPEED;
	else:
		motion.x = 0;
	self.move_and_slide(motion, UP)
	
func animate():
	emit_signal("animate", motion)
#	

func apply_gravity():
	if position.y > WORLD_LIMIT:
		get_tree().call_group("gamestate", "end_game")
	elif is_on_floor() and motion.y > 0:
		motion.y = 0;
	elif is_on_ceiling():
		motion.y = 1
	else:
		motion.y += GRAVITY

func hurt():
	position.y -= 1
	yield(get_tree(), "idle_frame")
	motion.y = -JUMP_SPEED
	$PainSFX.play()
	$Invincible.play("Invincible")
	

func boost():
	position.y -= 1
	yield(get_tree(), "idle_frame")
	motion.y -= BOOST_MULTIPLIER * JUMP_SPEED