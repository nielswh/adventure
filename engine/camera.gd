extends Camera2D

var roomX = 0
var roomY = 0

signal changedRoom(x, y)

func _process(delta):
	var pos = get_node('../player').global_position - Vector2(0,0)
	var x = floor(pos.x / 448) * 448
	var y = floor(pos.y / 256) * 256
	global_position = Vector2(x, y)
	
	var currentRoomX = floor( x / 448)
	var currentRoomY = floor( y / 256)
	
	if currentRoomX != roomX || currentRoomY != roomY:
		print('We are in a different room')
		roomX = currentRoomX
		roomY = currentRoomY
		emit_signal('changedRoom', roomX, roomY)
		
	 