extends Node2D

func generateParticles(start, end, distance):
	var p = []
	
	var i = start
	while i <= end:
		p.append(i)
		i += distance
	
	return p


func smoothingKernel(x1, x2, h = 0.13):
	# x1: point 1
	# x2: point 2
	# h: smoothing length
	# returns gradient of kernel

	var sub = x1 - x2
	var r = abs(sub)
	var div = r/h
	
	### without diff ###
	# var div2 = div * div
	# var div3 = div2 * div

	# var kernel
	# var _sub # tmp variable
	# if div >= 0 && div <= 1:
	# 	kernel = 1 - (3/2) * div2 + (3/4) * div3
	# elif div >= 1 && div <= 2:
	# 	_sub = (2 - div)
	# 	kernel = (1/4) * _sub * _sub * _sub
	# else:
	# 	kernel = 0

	### with diff ###
	var kernel
	if div >= 0 && div <= 1:
		kernel = (3 * r * (-4 * h + 3 *  r))/(4 * h * h * h)
	elif div >= 1 && div <= 2:
		sub = -2 * h + r
		kernel = -(3 * sub * sub)/(4 * h^3)
	else:
		kernel = 0

	return (sub/r) * kernel


func _ready():
	var particles = generateParticles(-10, 70, 0.04)

	var particle_mass = 0.04
	var fluid_density_0 = 1
	var pressure_0 = 10000
	var flow_valocity = 0

