extends Node2D


var towerAudio
var towerSprite
export var towerTurnSpeed = 3
var targetsInRange = []
export var projectilePreset = preload ("res://assets/graphic/projectiles/projectile_1.tscn")
export var projectileDamage = 10.0
var fireDelay = 0.0
export var fireRate = 2.0
var sellValue = 0
export var maxHealth = 100.0
export var health = 100.0
var explosionPreset = preload("res://assets/graphic/effects/explosion.tscn")

func _ready():
	towerAudio = get_node("towerAudio")
	towerSprite = get_node("towerSprite")
	health = maxHealth
	get_node("towerSprite/Node2D/health_foreground").value = maxHealth
	get_node("towerSprite/Node2D/health_foreground").max_value = maxHealth

func _process(delta):
	if targetsInRange.size() == 0:
		var targetRotation = 0
		var rotation = towerSprite.rotation_degrees
		var difference = abs(rotation - targetRotation)
		if targetRotation > rotation:
			rotation += min(difference, towerTurnSpeed)
		else:
			rotation -= min(difference, towerTurnSpeed)
		towerSprite.rotation_degrees = rotation
	else:
		
		var targetX = targetsInRange[0].get_parent().get_position().x
		var targetY = targetsInRange[0].get_parent().get_position().y
		#var targetX = get_viewport().get_mouse_position().x
		#var targetY = get_viewport().get_mouse_position().y
		var distX = targetX - towerSprite.get_parent().get_position().x
		var distY = targetY - towerSprite.get_parent().get_position().y
		var targetRotation = rad2deg(atan2(distY,distX)) + 90;

		var rotation = towerSprite.rotation_degrees

		#print(String(targetRotation) +" | "+String(rotation))
		if targetRotation > 180 && rotation < 0:
			if rotation <=-90:
				towerSprite.rotation_degrees = 270
				rotation = 270
			else:
				targetRotation = -90
		elif targetRotation < 0 && rotation > 180:
			if rotation >=270:
				towerSprite.rotation_degrees = -90
				rotation = -90
			else:
				targetRotation = 270
				
		var difference = abs(rotation - targetRotation)
		if targetRotation > rotation:
			rotation += min(difference, towerTurnSpeed)
		else:
			rotation -= min(difference, towerTurnSpeed)
		towerSprite.rotation_degrees = rotation
		
		if difference < 5:
			if fireDelay <= 0:
				if Engine.time_scale == 1 || GlobalSettings.twoXSound:
					$towerAudio.play()
				var projectile_temp = projectilePreset.instance()
				projectile_temp.rotation_degrees = towerSprite.rotation_degrees
				projectile_temp.direction = towerSprite.get_parent().get_position().direction_to(targetsInRange[0].get_parent().get_position())
				projectile_temp.position = projectile_temp.get_position() + projectile_temp.direction*32
				projectile_temp.damage = projectileDamage
				#print(targetsInRange[0].get_parent().rotation_degrees)
				add_child(projectile_temp)
				fireDelay = fireRate
			else:
				fireDelay = fireDelay - delta


func _on_fireRange_body_entered(body):
	targetsInRange.append(body)


func _on_fireRange_body_exited(body):
	targetsInRange.erase(body)
	
func sell():
	queue_free()
	
func damage(damage):
	health -= damage
	if health <= 0:
		var explosion_temp = explosionPreset.instance()
		explosion_temp.position = get_position()
		get_parent().add_child(explosion_temp)
		redraw_ground()
		queue_free()
	else:
		redraw_health_bar()

func redraw_health_bar():
	get_node("towerSprite/Node2D/health_foreground").value = health

func redraw_ground():
	var tileX = int(get_position().x/64)
	var tileY = int(get_position().y/64)
	var foregroundTileMap = get_node("/root/Level/foreground")
	foregroundTileMap.set_cell(tileX, tileY, 2)
	foregroundTileMap.update_dirty_quadrants()
	
func get_sell_value():
	return int(sellValue * (health/maxHealth))
