extends "res://engine/entity.gd"

var keys = 0
var hasMagnet = false
var useMagnet = false
var doorSpeed = 12
var doorVector  = dir.UP_VECTOR  * doorSpeed
var usingSword = false

func _ready():
	SPEED = 70
	TYPE = "PLAYER"
	

func controlLoop():
	
	var LEFT = Input.is_action_pressed('ui_left')
	var RIGHT = Input.is_action_pressed('ui_right')
	var UP = Input.is_action_pressed('ui_up')
	var DOWN = Input.is_action_pressed('ui_down')
	var ATTACK = Input.is_action_pressed('ui_attack')
		
	if (UP == true && LEFT == true):
		degrees = 225
		
	if (UP == true && RIGHT == true):
		degrees = 315 
		
	if (DOWN == true && LEFT == true):
		degrees = 135
		
	if (DOWN == true && RIGHT == true):
		degrees = 45 
		
	if (UP == true || DOWN == true || LEFT == true || RIGHT == true):	
		currentState = 'default'
		
	if (ATTACK == true && usingSword == true && isAttacking == false):
		currentState = 'attack'
		
	moveDir.x = -int(LEFT) + int(RIGHT)
	moveDir.y = -int(UP) + int(DOWN)

func _input(event):
	if (event is InputEventKey and event.pressed):
		if (event.scancode == KEY_1 && hasMagnet):
			useMagnet = !useMagnet
			print("Magnet toggle clicked")
	
		if (event.scancode == KEY_2):
			usingSword = true
			
		if (event.scancode == KEY_3):
			usingSword = false

func shockedState():
	$Sprite/AnimationPlayer.play('shock')
	
func defaultState():
		controlLoop()
		spriteDirLoop()
		
		
		doorVector = pushVector * doorSpeed
		
		if (is_on_wall() && test_move(transform, pushVector)):
			animationSwitch("Push")
		elif (moveDir != Vector2(0, 0)):
			animationSwitch("Run")
		else:
			$Sprite/AnimationPlayer.play('idle')
			
		movementLoop()
		
		if ($Light2D.rotation_degrees != degrees):
			$Light2D.rotation_degrees = degrees

func stopAttack(animation):
	currentState = "default"
	isAttacking = false
	isHitEnemy = false;
	print("stop attacking")
	
func attackState():
	
	if (isAttacking == false):
		isAttacking = true
		animationSwitch("attack")
		$Sprite/AnimationPlayer.connect("animation_finished",self, "stopAttack")
		
	damageLoop()
	
	
func _physics_process(delta):
	
	match currentState:
		"default":
			defaultState()
		"attack":
			attackState()
		"shock":
			shockedState()
