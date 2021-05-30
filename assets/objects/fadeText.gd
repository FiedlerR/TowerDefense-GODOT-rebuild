extends Label


export var travel = Vector2(0, -80)
export var duration = 2
export var spread = PI/2
export var value = "+ 10"

# Called when the node enters the scene tree for the first time.
func _ready():
	show_value(value, travel, duration, spread,false)

func show_value(value, travel, duration, spread, crit=false):
	text = value
	var movement = travel.rotated(rand_range(-spread/2, spread/2))
	rect_pivot_offset = rect_size / 2
	$Tween.interpolate_property(self, "rect_position", rect_position, rect_position + movement,duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.interpolate_property(self, "modulate:a",1.0, 0.0, duration,Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
	yield($Tween, "tween_all_completed")
	get_parent().queue_free()
