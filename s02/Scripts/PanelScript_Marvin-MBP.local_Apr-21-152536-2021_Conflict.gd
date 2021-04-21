extends Panel

const STATE_COLORS = {"STANDING":Color("black"), "DUCKING":Color("red"), 
"JUMPING":Color('green'),"DIVING":Color('blue')}

var state = 'STANDING'
var old_state = state

onready var panel = get_node(".")
onready var label = get_node("Label")

# Called when the node enters the scene tree for the first time.
func _ready():
	label.text = state
	_draw()

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
			state == 'STANDING'
			
#	if old_state != state:		
#		old_state = state
		label.text = state
		_draw()
		update()

func _draw():
	panel.get_stylebox()
