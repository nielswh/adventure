extends Area2D

const SPEED = 300
const TYPE = "PROJECTILE"
const velocity = Vector2()
var h_direction = 1
var v_direction = 0
var parent = self

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	velocity.x = SPEED * delta * h_direction
	velocity.y = SPEED * delta * v_direction
	translate(velocity)
	$AnimationPlayer.play("shoot")
	
	if (h_direction == -1):  #Left
		$Sprite.flip_h = true
	elif (v_direction == 1): # up
		$Sprite.rotation_degrees = 90
	elif  (v_direction == -1): #down
		$Sprite.rotation_degrees = -90
	
func setDirection(hdir, vdir, par):
	h_direction = hdir
	v_direction = vdir
	parent = par
			
func _on_VisibilityNotifier2D_screen_exited():
	print('off the screen')
	parent.setIsAttacking(false)
	queue_free()


func _on_Projectile_body_entered(body):
	if (body.get("TYPE") != "PLAYER"): # Replace with function body.
		
		if (body.get("TYPE") == "ENEMY"):
			body.set("isHit", true)
			
		parent.setIsAttacking(false)	
		queue_free()
