extends StaticBody2D

onready var effect = get_node('effect')
onready var sprite = get_node('Sprite')

func _ready():
	$area.connect("body_entered", self, "bodyEntered")
	
func bodyEntered(body):
	if body.name == 'player' && body.keys > 0:
		body.keys -= 1
		
		effect.interpolate_property(sprite, "position", sprite.position, body.doorVector, 1.5, 
        Tween.TRANS_LINEAR, Tween.EASE_OUT)
		effect.start()
		
func _on_effect_tween_completed(object, key):
	queue_free()
	print("done")
	
