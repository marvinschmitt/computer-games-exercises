# author: daniel knoll
# coauthor list: marvin schmitt


extends Node2D

class Astar:
	# Class to store graph node ellements
	class StarNode:
		# Node name
		var name: String
		# h-cost
		var h: int
		# g-cost
		var g: int
		# Parent node
		var lastNode: StarNode
		# An array of neighbour nodes
		var neighbors = []
		
	# Default constructor 
	# n - Node name
	# cost - node cost
		func _init(n, cost):
			self.name = n
			self.h = cost
			self.g = 0
			self.lastNode = null
			
		# Function to insert the neighbours
		func insertNeighbours(n: StarNode, cost: int):
			neighbors.push_back([n, cost])
			
	# Stores the final path
	var path = []
	# List of all cities
	var _cities = []
	# Start node
	var _start: StarNode
	# Target node
	var _target: StarNode
	# Current node
	var _currentNode: StarNode
	# Open list of StarNode nodes
	var _openList = []
	# Close list of nodes
	var _closeList = []
	
	# Constructor
	func _init():
		self._cities.push_back(StarNode.new("Frankfurt", 96))
		self._cities.push_back(StarNode.new("Keiserslautern", 158))
		self._cities.push_back(StarNode.new("Ludwigshafen", 108))
		self._cities.push_back(StarNode.new("Würzburg", 0))
		self._cities.push_back(StarNode.new("Heilbronn", 87))
		self._cities.push_back(StarNode.new("Karlsruhe", 140))
		self._cities.push_back(StarNode.new("Saarbrücken", 222))

		self._cities[0].insertNeighbours(self._cities[3], 116)
		self._cities[0].insertNeighbours(self._cities[1], 103)

		self._cities[1].insertNeighbours(self._cities[2], 53)
		self._cities[1].insertNeighbours(self._cities[6], 70)
		self._cities[1].insertNeighbours(self._cities[0], 103)

		self._cities[2].insertNeighbours(self._cities[1], 53)
		self._cities[2].insertNeighbours(self._cities[3], 183)

		self._cities[3].insertNeighbours(self._cities[0], 116)
		self._cities[3].insertNeighbours(self._cities[2], 183)
		self._cities[3].insertNeighbours(self._cities[4], 102)

		self._cities[4].insertNeighbours(self._cities[3], 102)
		self._cities[4].insertNeighbours(self._cities[5], 84)

		self._cities[5].insertNeighbours(self._cities[4], 84)
		self._cities[5].insertNeighbours(self._cities[6], 145)

		self._cities[6].insertNeighbours(self._cities[5], 145)
		self._cities[6].insertNeighbours(self._cities[1], 70)

		self._start = self._cities[6]
		self._target = self._cities[3]
			
	# Print the final path
	func printPath():
		var next = _target
		while next:
			path.append(next)
			print(String(next.name) + " " + String(next.g) )
			next = next.lastNode
			
	# Save the final path 
	func finalPath():
		var next = _target
		while next:
			path.append(next)
			next = next.lastNode
			
	# Print the open list
	func printOpenList():
		for iter in _openList:
			print(String(iter[0].name) + " " + String(iter[1]))
		print('')
	

	func findLowestFScore():
		var currentStar = self._openList[0]
		var bestF = currentStar[0].g + currentStar[0].h
		for i in self._openList.size():
			var currentF = _openList[i][0].g + _openList[i][0].h
			if currentF < bestF:
				bestF = currentF
				currentStar = _openList[i]
		_currentNode = currentStar[0]
		return currentStar[1]


	# returns an array with only StarNodes
	func generateNodeArray(nodes):
		var newArr = []
		for n in nodes:
			newArr.append(n[0])
		return newArr


	func expandNode():
		var n = _currentNode.neighbors
		for i in n.size():
			var closedNodes = generateNodeArray(_closeList)
			if (closedNodes.find(n[i][0]) >= 0):
				continue
			
			var tentative_g = _currentNode.g + n[i][1]
			
			print('CHECK', _openList.find(n[i]))
			if _openList.find(n[i]) >= 0 && tentative_g >= n[i][0].g:
				continue

			n[i][0].lastNode = _currentNode
			n[i][0].g = tentative_g

			var f = tentative_g + n[i][0].h

			# print('n i ', n[i], _openList)
			var nIdx = _openList.find(n[i])
			if nIdx >= 0:
				_openList[nIdx][1] = f
			else:
				n[i][1] = f
				_openList.append(n[i])


	func computePath() -> bool:
		# Enter your code here. You may add new functions
		_openList.append([_start, _start.g])
		printOpenList()

		while _openList.size() > 0:
			var f = findLowestFScore()
			_openList.remove(_openList.find([_currentNode, f]))

			if _currentNode == _target:
				return true
			
			_closeList.append([_currentNode, f])

			expandNode()
			printOpenList()
		return false
			

func _ready():
	# Create a class instance
	var pathSearch = Astar.new()
	
	# Compute and print the path
	if pathSearch.computePath():
		pathSearch.finalPath()
		var p = pathSearch.path
		var s = ""
		for i in p:
			s += i.name +  "\n"
		$Path.text = s
		pathSearch.printPath()
		return
	else:
		print("Error while computing path")	

