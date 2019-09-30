extends Node

const RIGHT_VECTOR = Vector2(1, 0)
const LEFT_VECTOR = Vector2(-1, 0)
const UP_VECTOR = Vector2( 0, -1)
const DOWN_VECTOR = Vector2(0, 1)
const CENTER_VECTOR = Vector2(0, 0)

func rand():
	print('calling Random')
	var d = randi() % 4 + 1
	
	match d:
		1: 
			return RIGHT_VECTOR
		2:
			return LEFT_VECTOR
		3:
			return UP_VECTOR
		4:
			return DOWN_VECTOR
			
	
func flip(direction):
	match direction:
		LEFT_VECTOR: 
			return RIGHT_VECTOR
		RIGHT_VECTOR:
			return LEFT_VECTOR
		DOWN_VECTOR:
			return UP_VECTOR
		UP_VECTOR:
			return DOWN_VECTOR