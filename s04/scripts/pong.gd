# author: Marvin Schmitt
# coauthor list: Daniel Knoll

extends Node2D

const WINNING_SCORE = 3

onready var _screen_size_x = get_viewport_rect().size.x
onready var _screen_size_y = get_viewport_rect().size.y

var _A_score = 0
var _B_score = 0
var running

# Called when the node enters the scene tree for the first time.
func _ready():
	_A_score = 0
	_B_score = 0
	running = true
	$Scoringboard/RestartButton.connect("pressed", self, "_onResetButtonPressed")

func reset():
	_A_score = 0
	_B_score = 0
	running = true
	$Scoringboard/Final_Score.text = ""
	update_score_labels()
	$Ball.reset()
	$Left.reset()
	$Right.reset()

func check_terminal_state():
	if _A_score == WINNING_SCORE:
		end_game('A')
	elif _B_score == WINNING_SCORE:
		end_game('B')
	else:
		return
	
func end_game(winner):
	running = false
	$Scoringboard/Final_Score.text = "Player "+winner+ " won!"

func ball_touched_wall(ball_position):
	if ball_position.x < (_screen_size_x / 2):
		_B_score += 1
	elif ball_position.x > (_screen_size_x / 2):
		_A_score += 1
	
	update_score_labels()
	check_terminal_state()

func update_score_labels():
	$Scoringboard/A_Score.text = str(_A_score)
	$Scoringboard/B_Score.text = str(_B_score)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _onResetButtonPressed():
	reset()
	$Ball.reset()
	
