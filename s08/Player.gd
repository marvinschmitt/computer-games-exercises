# author: Marvin Schmitt
# coauthor list: Daniel Knoll

extends KinematicBody2D

const WALK_FORCE = 600
const WALK_MAX_SPEED = 200
const STOP_FORCE = 5000
const JUMP_SPEED = 300

var velocity = Vector2()
var gravity = 500.0

# physics inspired by full code of official tutorial 
func _physics_process(delta):

	var walk = WALK_FORCE * (Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"))

	# stop or move
	if abs(walk) < WALK_FORCE * 0.2:
		velocity.x = 0
	else:
		velocity.x += walk * delta

	velocity.x = clamp(velocity.x, -WALK_MAX_SPEED, WALK_MAX_SPEED)

	# upward movement affected by gravity
	velocity.y += gravity * delta

	velocity = move_and_slide_with_snap(velocity, Vector2.DOWN, Vector2.UP)

	if is_on_floor() and Input.is_action_just_pressed("ui_select"):
		velocity.y = -JUMP_SPEED
