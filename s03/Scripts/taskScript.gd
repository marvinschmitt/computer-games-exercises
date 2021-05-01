# author list: Daniel Knoll
# coauthor: Marvin Schmitt
extends Node2D


var sprite1 = Node
var sprite2 = Node
var sprite3 = Node

var follow_speed = 4


func _ready():
	sprite1 = $Sprite1
	sprite2 = $Sprite2
	sprite3 = $Sprite3

	sprite1.transform.x = sprite2.transform.x * 2
	sprite1.transform.y = sprite2.transform.y * 2
	sprite1.position = Vector2(100, 100)

	sprite3.transform.x = sprite2.transform.x * 0.5
	sprite3.transform.y = sprite2.transform.y * 0.5
	sprite3.position = Vector2(500, 500)


func _physics_process(delta):
	var mouse_pos = get_local_mouse_position()

	sprite1.rotation += 10 * delta
	sprite2.rotation += 5 * delta
	sprite3.rotation -= 2.5 * delta

	sprite1.position = sprite1.position.linear_interpolate(mouse_pos, follow_speed * delta)
	sprite2.position = sprite2.position.linear_interpolate(sprite1.position, follow_speed * delta)
	sprite3.position = sprite3.position.linear_interpolate(sprite2.position, follow_speed * delta)


func _on_Timer3_timeout():
	sprite3.visible = false

func _on_Timer2_timeout():
	sprite2.visible = false

func _on_Timer1_timeout():
	sprite1.visible = false
