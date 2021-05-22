# author: Marvin Schmitt
# coauthor list: Daniel Knoll

extends Area2D

func _on_wall_area_entered(area):
	if area.name == "Ball":
		#oops, ball went out of game place, reset
		area.wall_touched()
