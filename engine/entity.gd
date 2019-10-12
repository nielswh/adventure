extends KinematicBody2D

var SPEED = 0
var moveDir = dir.CENTER_VECTOR
var spriteDir = "Up"
var degrees = 270
var shootHDirection = 1
var shootVDirection = 0
var pushVector = dir.UP_VECTOR
var currentState = "default"
var isAttacking = false
var isHitEnemy = false
var isHit = false;

var TYPE = "ENEMY"

func animationSwitch(animation):
	var newAnimation = str(animation,spriteDir)
	
	if ($Sprite/AnimationPlayer.current_animation != newAnimation):
		$Sprite/AnimationPlayer.play(newAnimation)

func damageLoop():
	if (isAttacking == true && isHitEnemy == false):
		for body in $hitbox.get_overlapping_bodies():
			if (body.get("TYPE") != TYPE):
				print(body.name)
				print(TYPE)
				print("hit enemey")
				isHitEnemy = true
				isAttacking = false
				body.set("isHit", true)

func spriteDirLoop():
	match moveDir:
		dir.LEFT_VECTOR:
			spriteDir = "Left"
			degrees = 180
			shootHDirection = -1
			shootVDirection = 0
			pushVector = dir.LEFT_VECTOR
		dir.RIGHT_VECTOR:
			spriteDir = "Right"
			shootHDirection = 1 
			shootVDirection = 0
			degrees = 0
			pushVector = dir.RIGHT_VECTOR
		dir.UP_VECTOR:
			spriteDir = "Up"
			degrees = 270
			shootHDirection = 0
			shootVDirection = -1
			pushVector = dir.UP_VECTOR
		dir.DOWN_VECTOR:
			spriteDir = "Down"
			degrees = 90
			shootHDirection = 0
			shootVDirection = 1
			pushVector = dir.DOWN_VECTOR

func movementLoop():
	var motion = moveDir.normalized() * SPEED
	move_and_slide(motion, dir.CENTER_VECTOR)
	
	