# Daniel Knoll
# Fakultät für Mathematik und Informatik
# Angewandte Informatik
# 3375411
# Marvin Schmitt

extends Label

var accum = 0

func _ready():
	add_to_group("UI")

func _process(delta):
	accum += delta
	text = str(accum)
