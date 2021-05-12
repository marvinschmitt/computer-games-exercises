# author: Marvin Schmitt
# coauthor list: Daniel Knoll

extends Panel

const STATE_COLORS = {"STANDING":Color(0,0,0, 1), "DUCKING":Color(1,0,0, 1), 
"JUMPING":Color(0,1,0,1),"DIVING":Color(0,0,1,1)}
var style = StyleBoxFlat.new()
var state = 'STANDING'

var old_state = state

onready var panel = get_node(".")
onready var label = get_node("Label")

# Called when the node enters the scene tree for the first time.
func _ready():
	label.text = state
	add_stylebox_override("panel", style)
	set_process(true)
	_draw()
	update()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if state == 'DUCKING':
		if Input.is_action_pressed("M_key"):
			state = 'STANDING'
			
	elif state == 'STANDING':
		if Input.is_action_pressed("N_key"):
			state = 'DUCKING'
		elif Input.is_action_pressed("B_key"):
			state = 'JUMPING'
			
	elif state == 'JUMPING':
		if Input.is_action_pressed("N_key"):
			state = 'DIVING'
			
	elif state == 'DIVING':
		if Input.is_action_pressed("M_key"):
			state = 'STANDING'
			
	if old_state != state:		
		old_state = state
		label.text = state
		_draw()
		update()

func _draw():
	var color = STATE_COLORS[state]
	style.set_bg_color(color)
