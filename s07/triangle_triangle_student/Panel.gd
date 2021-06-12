# author: marvin schmitt
# coauthor list: daniel knoll

extends Panel


class Triangle3D:
	var a: Vector3
	var b: Vector3
	var c: Vector3
	
	func _init(param1: Vector3, param2: Vector3, param3: Vector3):
		self.a = param1
		self.b = param2
		self.c = param3
		
	func lineCrossing3D(p1: Vector3, v1: Vector3, p2: Vector3, v2: Vector3):
#		Input: p1: the start point on line segment 1
#		Input: v1: the direction and length of line segment 1
#		Input: p2: the start point on line segment 2
#		Input: v2: the direction and length of line segment 2
#		Output: true when the two line segments intersect each other

#		TODO: implement this function
		# check if vector are parallel
		if v1.normalized() == v2.normalized():
			return false; # vectors are parallel

		# check if vectors cross

		return false	
	
	
	func pointIsInside(p: Vector3):  
#		Input: p: one point
#		Output: true when the point is inside the triangle

#		TODO: implement this function

		return false
		
		
	func collide2D(t: Triangle3D):
#		Input: t: the second triangle
#		Output: true when the two triangles collide each other in 2D

#		TODO: implement for the 2D intersection case
#		TODO: call pointIsInside() and lineCrossing3D() if necessary
	
		return false
		
			
	func collide(t: Triangle3D) -> bool:
#		Input: t: the second triangle
#		Output: true when the two triangles collide each other in 3D

#		TODO: compute the plane normal vectors (It is not important to normalize the vectors here!)
		var v1 = self.a + (self.b - self.a)
		var v2 = self.a + (self.c - self.a)
		
		var u1 = t.a + (t.b - t.a)
		var u2 = t.a + (t.c - t.a)
		
		var cross1 = v1.cross(v2)
		var cross2 = u1.cross(u2)

		
#		TODO: check the basic conditions and apply the following print code correspondingly
#		print("Parallel planes case.")
#		print("2D intersection case.")
#		print("3D intersection case.")
			
#		TODO: for the 2D intersection case, call collide2D()

#		TODO: implement for the 3D intersection case
			
		return false
	
	
var T1a: Vector3
var T1b: Vector3
var T1c: Vector3
	
var T2a: Vector3
var T2b: Vector3
var T2c: Vector3
		

func test(id: String, expected: String):
	var T1o = Triangle3D.new(T1a, T1b, T1c)
	var T2o = Triangle3D.new(T2a, T2b, T2c)

	print("3D-test ", id, ":")
	var result = T1o.collide(T2o)
	print("It should be: ", expected, ". Your output is: ", result, ".\n")
	
	get_node("Label_" + id + "_1").text = "3D-test " + id + ":"
	get_node("Label_" + id + "_2").text = "It should be: " + expected + ". Your output is: " + String(result) + "."
	
	
# Called when the node enters the scene tree for the first time.
func _ready():
	
#	Test 1a
	T1a = Vector3(1, 1, 1)
	T1b = Vector3(1, 1, 4)
	T1c = Vector3(1, 2, 2)

	T2a = Vector3(1, 1, 1)
	T2b = Vector3(1, 1, 5)
	T2c = Vector3(1, 2, 3)
	
	test("1a", "True")
	
	
#	Test 1b
	T1a = Vector3(1, 1, 1)
	T1b = Vector3(1, 1, 4)
	T1c = Vector3(1, 2, 2)

	T2a = Vector3(2, 1, 1)
	T2b = Vector3(2, 1, 4)
	T2c = Vector3(2, 2, 2)
	
	test("1b", "False")
	
	
#	Test 2
	T1a = Vector3(1, 1, 1)
	T1b = Vector3(1, 1, 5)
	T1c = Vector3(1, 3, 4)

	T2a = Vector3(0, 2, 1)
	T2b = Vector3(0, 2, 5)
	T2c = Vector3(2, 2, 4)
	
	test("2", "True")
	
	
#	Test 3
	T1a = Vector3(1, 1, 1)
	T1b = Vector3(1, 1, 5)
	T1c = Vector3(1, 3, 4)

	T2a = Vector3(0, 2, 6)
	T2b = Vector3(0, 2, 8)
	T2c = Vector3(2, 2, 7)
	
	test("3", "False")
	
	
#	Test 4
	T1a = Vector3(1, 1, 1)
	T1b = Vector3(1, 1, 5)
	T1c = Vector3(1, 3, 4)

	T2a = Vector3(0, 2, 2)
	T2b = Vector3(0, 2, 6)
	T2c = Vector3(2, 2, 5)
	
	test("4", "True")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
