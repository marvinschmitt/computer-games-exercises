# Author: Marvin Schmitt
# Coauthor list: Daniel Knoll

extends Node2D

# constants
var spacing = 0.04
var h = 0.13
var c0 = 340

var fluid_density_0 = 1
var pressure_0 = 10000

var particles = []
var N = []
var mass = []
var fluid_density = []
var delta_p = []
var pressure = []
var flow_velocity = []

var t = 0


func generateParticles(start, end, distance):
	var p = []
	
	var i = start
	while i <= end:
		p.append(i)
		i += distance
	
	return p


func smoothingKernel(i, j):
	var sub = particles[i] - particles[j]
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
		kernel = (3 * r * (-4 * h + 3 * r))/(4 * h * h * h)
	elif div >= 1 && div <= 2:
		sub = -2 * h + r
		kernel = -(3 * sub * sub)/(4 * h * h * h)
	else:
		kernel = 0

	return (sub/r) * kernel


func densityApproximation(i):
	var sum = 0
	for j in N[i]:
		var kernel = smoothingKernel(i, j)
		sum += (mass[j] / (fluid_density_0 + delta_p[j])) * (flow_velocity[i] - flow_velocity[j]) * kernel
	return (fluid_density_0 + delta_p[i]) * sum


func flowVelocityApproximation(i):
	var sum = 0
	for j in N[i]:
		var c2 = c0 * c0
		var pd_i = pressure_0 + delta_p[i]
		var pd_j = pressure_0 + delta_p[j]

		var div1 = (c2 * delta_p[i]) / (pd_i * pd_i)
		var div2 = (c2 * delta_p[j]) / (pd_j * pd_j)
		var kernel = smoothingKernel(i, j)
		sum += mass[j] * (div1 + div2) * kernel
	return sum


func _ready():
	particles = generateParticles(-10, 70, spacing)

	# generate state vectors
	for particle in particles:
		mass.append([0.04])
		fluid_density.append([1])
		delta_p.append([0])
		pressure.append([10000])
		flow_velocity.append([0])

	# generate N for each particle
	for i in range(particles.size()):
		N.append([])
		for j in range(particles.size()):
			if particles[j] >= particles[i] - h && particles[j] <= particles[i] + h:
				N[i].append(j)


func _process(delta):
	while t < 2:
		for i in range(particles.size()):
			densityApproximation(i)

		t += delta
