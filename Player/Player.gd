extends KinematicBody2D

const SPEED = 70

var moveDir = Vector2(0,0)
var keys = 0


func controlLoop():
	var LEFT = Input.is_action_pressed('ui_left')
	var RIGHT = Input.is_action_pressed('ui_right')
	var UP = Input.is_action_pressed('ui_up')
	var DOWN = Input.is_action_pressed('ui_down')
	
	moveDir.x = -int(LEFT) + int(RIGHT)
	moveDir.y = -int(UP) + int(DOWN)
	
func movementLoop():
	var motion = moveDir.normalized() * SPEED
	move_and_slide(motion, Vector2(0,0))
	

func _physics_process(delta):
	controlLoop()
	movementLoop()

