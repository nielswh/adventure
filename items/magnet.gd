extends Area2D

onready var effect = get_node('effect')
onready var sprite = get_node('Sprite')

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", self, "bodyEntered")
	
	effect.interpolate_property(sprite, 'scale', sprite.transform.get_scale(),
		Vector2(0.0, 0.0), 0.4, 
		Tween.TRANS_QUAD, Tween.EASE_OUT)
		
	effect.interpolate_property(sprite, 'modulate', Color(1, 1, 1, 1), 
		Color(1, 1, 1, 0), 0.4,
		Tween.TRANS_QUAD, Tween.EASE_OUT)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func bodyEntered(body):
	
	if (body.name == 'player'):
		print("We got the magnet")
		effect.start()
		body.hasMagnet = true
		
func _on_effect_tween_completed(object, key):
	print("destory mag")
	queue_free()
	