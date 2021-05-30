extends Node2D


export var timeTolive = 1.5
func _ready():
	print(get_parent())
	if Engine.time_scale == 1:
		$AudioStreamPlayer2D.play()
		
func _process(delta):
	if timeTolive > 0:
		timeTolive = timeTolive - delta
	else:
		queue_free()
