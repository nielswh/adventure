extends Area2D

func _ready():
	connect("body_entered", self, "bodyEntered")
	
func _process(delta):
	var camera = get_node('../camera')
	
	var pos = global_position - Vector2(0,0)
	var x = floor(pos.x / 448) * 448
	var y = floor(pos.y / 256) * 256
	
	var roomX = floor(x / 448)
	var roomY = floor(y / 256)
	
	if camera.roomX == roomX && camera.roomY == roomY:
		var playerNode = get_node('../player')
		var distanceToPlayer = playerNode.global_position.distance_to(global_position); 
		if (distanceToPlayer < 100.0):
			var ang = get_angle_to(playerNode.position)
			rotate(ang* 1.5 * delta)
			var speed = (100.0 - distanceToPlayer) / 2.0
			var direction = (playerNode.position - position).normalized()
			var motion = direction * speed * delta
			position += motion
	
func bodyEntered(body):
	
	if (body.name == 'player'):
		body.keys += 1
		queue_free()
		
