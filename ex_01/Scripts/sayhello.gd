# Daniel Knoll
# Fakultät für Mathematik und Informatik
# Angewandte Informatik
# 3375411
# Marvin Schmitt

# Why is it important to know the time between two frames in a game?
#
# It's important to know the time, because you can make physics and movement calculations
# independed of the framerate by multiplying the time delta. That way the game acts
# consistent, because framerates are very variable.

extends Panel

onready var label = get_node("Label")
var counterEnabled: bool = false;
var acc = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	label.text = "Hello!"
	get_node('Button').connect("pressed", self, "_onButtonPressed")

func _process(delta):
	if counterEnabled:
		acc += delta
		label.text = str(acc)

func _onButtonPressed():
	if counterEnabled:
		acc = 0
	counterEnabled = !counterEnabled
