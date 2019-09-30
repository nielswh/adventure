extends KinematicBody2D

var SPEED = 0
var moveDir = dir.CENTER_VECTOR
var spriteDir = "Up"
var degrees = 270
var pushVector = dir.UP_VECTOR
var  currentState = "default"
var isAttacking = false
var isHitEnemy = false;
var isHit = false;

var TYPE = "ENEMY"

func animationSwitch(animation):
	var newAnimation = str(animation,spriteDir)
	
	if ($Sprite/AnimationPlayer.current_animation != newAnimation):
		$Sprite/AnimationPlayer.play(newAnimation)


func damageLoop():
	
	if (isAttacking == true  && isHitEnemy == false):
		for body in $hitbox.get_overlapping_bodies():
			if (body.get("TYPE") != TYPE):
				print(body.name)
				print(TYPE)
				print("hit enemey")
				isHitEnemy = true
				body.set("isHit", true)

func spriteDirLoop():
	match moveDir:
		dir.LEFT_VECTOR:
			spriteDir = "Left"
			degrees = 180
			pushVector = dir.LEFT_VECTOR
		dir.RIGHT_VECTOR:
			spriteDir = "Right"
			degrees = 0
			pushVector = dir.RIGHT_VECTOR
		dir.UP_VECTOR:
			spriteDir = "Up"
			degrees = 270
			pushVector = dir.UP_VECTOR
		dir.DOWN_VECTOR:
			spriteDir = "Down"
			degrees = 90
			pushVector = dir.DOWN_VECTOR

func movementLoop():
	var motion = moveDir.normalized() * SPEED
	move_and_slide(motion, dir.CENTER_VECTOR)
	
	