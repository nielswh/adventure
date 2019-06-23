extends KinematicBody2D

const SPEED = 70

var moveDir = Vector2(0,0)
var keys = 0
var hasMagnet = false
var useMagnet = false
var doorSpeed = 20
var doorVector  = Vector2(doorSpeed,0)



func controlLoop():
	var LEFT = Input.is_action_pressed('ui_left')
	var RIGHT = Input.is_action_pressed('ui_right')
	var UP = Input.is_action_pressed('ui_up')
	var DOWN = Input.is_action_pressed('ui_down')
	
	if (LEFT):
		doorVector = Vector2(-doorSpeed,0)
		
	if (RIGHT):
		doorVector = Vector2(doorSpeed,0)
	
	if (UP):
		doorVector = Vector2(0,-doorSpeed)
		
	if (DOWN):
		doorVector = Vector2(0,doorSpeed)
	
	moveDir.x = -int(LEFT) + int(RIGHT)
	moveDir.y = -int(UP) + int(DOWN)
	
func movementLoop():
	var motion = moveDir.normalized() * SPEED
	move_and_slide(motion, Vector2(0,0))


func _input(event):
	if (event is InputEventKey and event.pressed):
		if (event.scancode == KEY_1 && hasMagnet):
			useMagnet = !useMagnet
			print("Magnet toggle clicked")
			

func _physics_process(delta):
	controlLoop()
	movementLoop()
