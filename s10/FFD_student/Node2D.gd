# Author: Marvin Schmitt
# Coauthor list: Daniel Knoll

extends Node2D

var w = 300 # width of the image
var h = 300 # height of the image

var image_ori = [] # original image color data
var image_deformed = [] # deformed image color data

# grid of deformation control points
# dx[0][3] = 0 means the displacement in x of the control point with index (0, 3)
class DeformGrid: 
	var dx = []
	var dy = []
	func _init():
		for i in range(4):
			dx.append([])
			dy.append([])
			for _j in range(4):
				dx[i].append([])
				dy[i].append([])
		
		# set some values
		dx[0][3] = 0; dx[1][3] = 0; dx[2][3] = 0; dx[3][3] = 0
		dx[0][2] = 100; dx[1][2] = 100; dx[2][2] = 100; dx[3][2] = 100
		dx[0][1] = -100; dx[1][1] = -100; dx[2][1] = -100; dx[3][1] = -100
		dx[0][0] = 0; dx[1][0] = 0; dx[2][0] = 0;   dx[3][0] = 0; 
		
		dy[0][3] = 0;  dy[1][3] = 100; dy[2][3] = -100; dy[3][3] = 0; 
		dy[0][2] = 0;  dy[1][2] = 100; dy[2][2] = -100; dy[3][2] = 0; 
		dy[0][1] = 0;  dy[1][1] = 100; dy[2][1] = -100; dy[3][1] = 0; 
		dy[0][0] = 0;  dy[1][0] = 100; dy[2][0] = -100; dy[3][0] = 0; 
		
	
func createEmptyScene():
# create an empty image
	for x in range(w):
		image_ori.append([])
		for _y in range(h):
			image_ori[x].append([Color(1,1,1)])


func createEmptyDeformedScene():
# create an empty image
	for x in range(w):
		image_deformed.append([])
		for _y in range(h):
			image_deformed[x].append([Color(1,1,1)])


func createTestImage():
	# create white background
	for i in range(w):
		for j in range(h):
			image_ori[i][j] = Color(1, 1, 1)

#create red grid:
	for i in range(0, w-1, 20):
		for j in range(h):			
			image_ori[i][j] = Color(1, 0, 0, 1)
			image_ori[i+1][j] = Color(1, 0, 0, 1)
			image_ori[j][i] = Color(1, 0, 0, 1)
			image_ori[j][i+1] = Color(1, 0, 0, 1)
			
	# other stuff
	for i in range(50, 100):
		for j in range(100, 150):
			image_ori[i][j] = Color(0.5*(image_ori[i][j][0]), 
										0.5*(image_ori[i][j][1] + 1),
										0.5*(image_ori[i][j][2]))

	for i in range(250, 300):
		for j in range(50, 250):
			image_ori[i][j] = Color(0.5*(image_ori[i][j][0]), 
										0.5*(image_ori[i][j][1] + 1),
										0.5*(image_ori[i][j][2]))
			

	for i in range(160, 200):
		for j in range(200, 270):
			image_ori[i][j] = Color(0.5*(image_ori[i][j][0]), 
										0.5*(image_ori[i][j][1]),
										0.5*(image_ori[i][j][2] + 1))
										

	for i in range(10, 110):
		for j in range(140, 190):
			image_ori[i][j] = Color(0.5*(image_ori[i][j][0]), 
										0.5*(image_ori[i][j][1]),
										0.5*(image_ori[i][j][2] + 1))

#
#func factorial(n):
#	var prod = 1.0
#	for i in range(1, n+1):
#		prod *= i
#	return prod
#	
#func binom_coef(n, k):
#	return factorial(n) / (factorial(k) * factorial(n-k))
#
#func GeneralBezier(t, k, n):
#	return binom_coef(n, k) * pow(1-t, n-k) * pow(t, k)


func LinearBezier(t, k):
	# return the linear bezier polynoms:
	# t: float value in [0,1]
	# k: polynom index
#	TODO: compute and return the polynom weights
	return (1-t)*k + t*k

func CubicBezier(t, k):
	# return the cubic bezier polynoms:
	# t: float value in [0,1]
	# k: polynom index
#	TODO: compute and return the polynom weights
	var sum = pow((1-t),3) * k[0][0] + 3 * pow((1-t),2) * t * k[1][1] + 3 * (1-t) * pow(t,2) * k[2][2] + pow(t,3)* k[3][3]
	return sum



func createDeformedImage():
	var grid = DeformGrid.new()
	var u; var v
	var dx; var dy
	var posx; var posy
	var r; var g; var b; var o
	
	for i in range(w):
		for j in range(h):
#			compute the position u,v in [0 1] in x- and y-direction in the spline:
			u = 1.0 / (w - 1) * i
			v = 1.0 / (h - 1) * j

#		    compute the displacements dx,dy of the voxel according to the deformation
#           grid for the position (u,v) using the cubic Bezier spline 
			dx = 0; dy = 0
#			TODO: Please complete the code using CubicBezier function
#			HINT: sum over control points in x- and y-direction to get the displacement vector!
#			 		dx += 
#			 		dy += 
			dx += CubicBezier(v, grid.dx)
			dy += CubicBezier(u, grid.dy)


#			deformed position (corner with the lowest indices for the linear interpolation) 
			posx = int(i + dx);
			posy = int(j + dy);
			
#           if the pixel is outside of original image, set the colors to 0
#           otherwise the pixel is linearly interpolated by the 4 nearby grid points
			if posx < 0 or posx >= w or posy < 0 or posy >= h:
				image_deformed[i][j] = Color(0.0, 0.0, 0.0, 1.0)
			else:
				
				r = 0; g = 0; b = 0; o = 1
	#			TODO: Please complete the code here using LinearBezier function
	#			HINT: 
				r += LinearBezier(u, image_ori[posx][posy].r)
				g += LinearBezier(u, image_ori[posx][posy].g)
				b += LinearBezier(u, image_ori[posx][posy].b)

	#			set the computed color values for the pixel in the deformed image
				image_deformed[i][j] = Color(r, g, b, o)


func drawScene(scene):
	var points
	var col
	# draw the content of image_ori in the window
	for i in range(w):
		for j in range(h):
			points = PoolVector2Array([Vector2(i, j)])
			col = PoolColorArray([scene[i][j]])
			draw_primitive(points, col, PoolVector2Array(), null, 1)
		

var def = true
func _draw():
	if def == false:
		drawScene(image_deformed)
		$Button.text = "Deformed"
	else:
		drawScene(image_ori)
		$Button.text = "Original"

# Called when the node enters the image_ori tree for the first time.
func _process(_delta):
	update()

func _ready():
	createEmptyScene()
	createEmptyDeformedScene()
	createTestImage()
	createDeformedImage()
	print("Deformation completed!")


func _on_Button_toggled(button_pressed):
	if (button_pressed):
		def = false
	else:
		def = true
