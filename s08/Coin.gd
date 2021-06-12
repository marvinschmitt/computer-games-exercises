# author: Marvin Schmitt
# coauthor list: Daniel Knoll

extends Area2D

signal hit

func _ready():
	pass # Replace with function body.


func _on_Coin_body_entered(body):
	emit_signal("hit")

