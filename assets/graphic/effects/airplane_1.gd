extends Node2D

var direction
export var speed = 300
var timeTolive = 10
func _ready():
	direction = -global_transform.y.normalized()

func _process(delta):
	
	if timeTolive > 0:
		timeTolive = timeTolive - delta
		set_position(get_position() + direction*speed*delta)
	else:
		queue_free()

