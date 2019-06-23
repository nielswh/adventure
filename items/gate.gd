extends StaticBody2D

onready var effect = get_node('effect')
onready var sprite = get_node('Sprite')

onready var playerPos = Vector2(0,0)

func _ready():
	$area.connect("body_entered", self, "bodyEntered")
		
		
	
	
func bodyEntered(body):
	if body.name == 'player' && body.keys > 0:
		print(body.doorVector)
		playerPos = body.doorVector		
		body.keys -= 1
		
		effect.interpolate_property(sprite, "position", sprite.position, playerPos, 1, 
        Tween.TRANS_LINEAR, Tween.EASE_OUT)
		effect.start()
		
func _on_effect_tween_completed(object, key):
	queue_free()
	print("done")
	
