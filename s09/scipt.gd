# author: Daniel Knoll
# coauthor list: Marvin Schmitt 

extends Sprite

var locations = []
var derivatives = [Vector2(2,0),Vector2(1,2),Vector2(2,1),Vector2(1,-2),Vector2(2,0)]
var speed = 100
var catmull = 0

var t = 0
var key = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	# add derivatives for waypoints
	locations.append(get_node("../sphere1").transform.origin)
	locations.append(get_node('../sphere2').transform.origin)
	locations.append(get_node('../sphere3').transform.origin)
	locations.append(get_node('../sphere4').transform.origin)
	locations.append(get_node('../sphere5').transform.origin)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	t += delta
	if (t >= 1):
		# next keypoint
		t = 0
		key += 1

	var idx1 = key % locations.size()
	var idx2 = (key + 1) % locations.size()

	# calculate derivatives
	var d0 = Vector2()
	var d1 = Vector2()
	if (catmull == 1):
		d0 = 0.5 * (locations[(idx1+1) % 5] - locations[(idx1-1) % 5]) * speed
		d1 = 0.5 * (locations[(idx2+1) % 5] - locations[(idx2-1) % 5]) * speed
	else:
		d0 = derivatives[idx1] * speed
		d1 = derivatives[idx2] * speed
		
	# calculate hermite spline
	var t2 = t * t
	var t3 = t2 * t

	var h11 = t3 - t2
	var h01 = t3 - 2 * t2 + t
	var h10 = -2 * t3 + 3 * t2
	var h00 = 2 * t3 - 3 * t2 + 1
	var c = h00 * locations[idx1] + h10 * locations[idx2] + h01 * d0 + h11 * d1

	# move ball
	move(c)


func move(c):
	transform.origin = c


func _on_speedEdit_text_changed(new_text):
	speed = int(new_text)


func _on_modeEdit_text_changed(mode):
	if (mode == '0'):
		catmull = int(mode)
	elif (mode == '1'):
		catmull = int(mode)
