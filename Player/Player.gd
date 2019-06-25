extends KinematicBody2D

const SPEED = 70

var moveDir = Vector2(0,0)
var keys = 0
var hasMagnet = false
var useMagnet = false
var doorSpeed = 12
var doorVector  = Vector2(doorSpeed,0)
var shocked = false
var lastDegree = 0

func controlLoop():
	var LEFT = Input.is_action_pressed('ui_left')
	var RIGHT = Input.is_action_pressed('ui_right')
	var UP = Input.is_action_pressed('ui_up')
	var DOWN = Input.is_action_pressed('ui_down')
	
	var degrees = -1
	
	if (LEFT):
		doorVector = Vector2(-doorSpeed,0)
		$Sprite/AnimationPlayer.play('RunLeft')
		degrees = 180
		
	if (RIGHT):
		doorVector = Vector2(doorSpeed,0)
		$Sprite/AnimationPlayer.play('RunRight')
		degrees = 0
	
	if (UP):
		doorVector = Vector2(0,-doorSpeed)
		$Sprite/AnimationPlayer.play('RunLeft')
		degrees = 270
		
	if (DOWN):
		doorVector = Vector2(0,doorSpeed)
		$Sprite/AnimationPlayer.play('RunRight')
		degrees = 90
	
	if (UP == true && LEFT == true):
		degrees = 225
		
	if (UP == true && RIGHT == true):
		degrees = 315 
		
	if (DOWN == true && LEFT == true):
		degrees = 135
		
	if (DOWN == true && RIGHT == true):
		degrees = 45 
		
	if (degrees == -1):
		degrees = lastDegree
	else:
		lastDegree = degrees
			
	moveDir.x = -int(LEFT) + int(RIGHT)
	moveDir.y = -int(UP) + int(DOWN)
	
	$Light2D.rotation_degrees = degrees
	
func movementLoop():
	var motion = moveDir.normalized() * SPEED
	if (motion.x == 0 && motion.y == 0):
		$Sprite/AnimationPlayer.play('idle')
		
	move_and_slide(motion, Vector2(0,0))


func _input(event):
	if (event is InputEventKey and event.pressed):
		if (event.scancode == KEY_1 && hasMagnet):
			useMagnet = !useMagnet
			print("Magnet toggle clicked")
			

func _physics_process(delta):
	if (!shocked):
		controlLoop()
		movementLoop()
	else:
		$Sprite/AnimationPlayer.play('shock')

