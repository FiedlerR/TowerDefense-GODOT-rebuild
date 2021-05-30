extends TextureButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speed = 1.0

# Called when the node enters the scene tree for the first time.
func _ready():
	speed = Engine.time_scale


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_speed_pressed():
	if Engine.time_scale != 0:
		if speed == 1:
			$normalSpeed.visible = false
			$fastSpeed.visible = true
			speed = 3
			Engine.time_scale = speed
		else:
			$normalSpeed.visible = true
			$fastSpeed.visible = false
			speed = 1
			Engine.time_scale = speed
