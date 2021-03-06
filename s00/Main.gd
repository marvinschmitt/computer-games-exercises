# name: Marvin Schmitt
# faculty: Mathematik und Informatik
# discipline: Computer Science Master
# student number: 3287523
# coauthor list: David Knoll

extends Node

export (PackedScene) var Ball

func _input(event):
	if event.is_action_pressed("click"):
		var new_ball = Ball.instance()
		new_ball.position = get_viewport().get_mouse_position()
		add_child(new_ball)
