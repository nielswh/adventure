extends "res://engine/entity.gd"

onready var effect = get_node('effect')

var isFinal = false

func _ready():
	SPEED = 2
	moveDir = dir.rand()
	
	print('Ready')
	
func shockedState():
	pass

func dieForEver(animation):
	print("died")
	queue_free()
	
func defaultState():
	if (isFinal == true):
		print('done no loop')
		pass
		
	spriteDirLoop()
	
	if (isHit == true):
		isFinal = true
		
		$Sprite/AnimationPlayer.play('die')
		moveDir = dir.CENTER_VECTOR
		$CollisionShape2D.set_deferred("disabled", true)
		$Sprite/AnimationPlayer.connect("animation_finished",self, "dieForEver")
		
	elif (is_on_wall() && test_move(transform, pushVector)):
		currentState = "shocked"
		animationSwitch("Push")
		moveDir = dir.flip(pushVector)
		pushVector = moveDir
		print(self.position)
		effect.interpolate_property(self, "position", self.position, self.position * -2, 1.5, 
    		Tween.TRANS_LINEAR, Tween.EASE_OUT)
		
		effect.start()
	elif (moveDir != dir.CENTER_VECTOR):
		animationSwitch("Run")
	else:
		$Sprite/AnimationPlayer.play('idle')
		
	if (isHit == false):
		movementLoop()
	
func _physics_process(delta):
	
	match currentState:
		"default":
			defaultState()
		"shocked":
			shockedState()

func _on_effect_tween_completed(object, key):
	currentState = "default"
	$Sprite/AnimationPlayer.play('idle')
	print("done")
