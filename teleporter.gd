extends Area2D

export (int) var teleporterNumber = 1

func _ready():
	connect("body_entered", self, "bodyEntered")
	
func bodyEntered(body):
	if body.name == 'player':
		if teleporterNumber == 11:
			body.position.x = 158.0
			body.position.y = 158.0
		elif teleporterNumber == 2:
			body.position.x = 1488.0
			body.position.y = 573.0


