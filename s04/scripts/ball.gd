# author: Marvin Schmitt
# coauthor list: Daniel Knoll

extends Area2D

const DEFAULT_SPEED = 100

onready var PongGame = get_tree().get_root().get_node("Pong")

var direction = Vector2.LEFT

onready var _initial_pos = position
onready var _speed = DEFAULT_SPEED

func _process(delta):
	if PongGame.running:
		_speed += delta * 2
		position += _speed * delta * direction

func wall_touched():
	PongGame.ball_touched_wall(position)
	reset()

func reset():
	direction = Vector2.LEFT if randi()%2 else Vector2.RIGHT # random start direction
	position = _initial_pos
	_speed = DEFAULT_SPEED
