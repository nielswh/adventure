extends StaticBody2D

func _ready():
	$area.connect("body_entered", self, "bodyEntered")
	
func bodyEntered(body):
	if body.name == 'player' && body.keys > 0:
		body.keys -= 1
		queue_free()
