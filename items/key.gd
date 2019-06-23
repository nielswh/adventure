extends Area2D

onready var camera = get_node('../camera')
onready var effect = get_node('effect')
onready var sprite = get_node('Sprite')

var maxDistance = 100.0
var rotateSpin = 2.5
var isFound = false

func _ready():
	connect("body_entered", self, "bodyEntered")
	
	effect.interpolate_property(sprite, 'scale', sprite.transform.get_scale(),
		Vector2(0.0, 0.0), 0.4, 
		Tween.TRANS_QUAD, Tween.EASE_OUT)
		
	effect.interpolate_property(sprite, 'modulate', Color(1, 1, 1, 1), 
		Color(1, 1, 1, 0), 0.4,
		Tween.TRANS_QUAD, Tween.EASE_OUT)
	
func _process(delta):
		
	var pos = global_position - Vector2(0,0)
	var roomX = floor(pos.x / 448)
	var roomY = floor(pos.y / 256)
	
	if camera.roomX == roomX && camera.roomY == roomY:
		var playerNode = get_node('../player')
		var distanceToPlayer = playerNode.global_position.distance_to(global_position); 
		
		if (distanceToPlayer < maxDistance):
			rotate(get_angle_to(playerNode.position) * rotateSpin * delta)
			var speed = (maxDistance - distanceToPlayer) / 2.0
			var direction = (playerNode.position - position).normalized()
			var motion = direction * speed * delta
			position += motion
	
func bodyEntered(body):
	
	if (body.name == 'player'):
		isFound = true
		body.keys += 1
		effect.start()
		
		

func _on_effect_tween_completed(object, key):
	queue_free()
