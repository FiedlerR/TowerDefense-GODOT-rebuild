extends Node2D

var direction
export var speed = 200
var bombTimer = 0.5
var timeTolive = 20
var bombPreset = preload("res://assets/graphic/effects/bomb_destruction.tscn")
func _ready():
	direction = -global_transform.y.normalized()

func _process(delta):
	
	if timeTolive > 0:
		timeTolive = timeTolive - delta
		set_position(get_position() + direction*speed*delta)
		
		if bombTimer <= 0:
			if Engine.time_scale == 1 || GlobalSettings.twoXSound:
				$bombAudio.play()
			var bomb_temp = bombPreset.instance()
			bomb_temp.position = position
			get_parent().add_child(bomb_temp)
			bombTimer = 0.5
			redraw_ground()
		else:
			bombTimer -= delta
	else:
		queue_free()

func redraw_ground():
	var tileX = int(global_position.x/64)
	var tileY = int(global_position.y/64)
	var foregroundTileMap = get_node("/root/Level/foreground")
	foregroundTileMap.set_cell(tileX, tileY, 2)
	foregroundTileMap.update_dirty_quadrants()



func _on_Area2D_body_entered(body):
	body.get_parent().takeDamage(20)
