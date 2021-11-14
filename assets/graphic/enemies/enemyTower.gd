extends Node2D


var towerAudio
var tankTowerObject
export var towerTurnSpeed = 3
var targetsInRange = []
export var projectilePreset = preload ("res://assets/graphic/projectiles/projectile_enemy_1.tscn")
export var projectileDamage = 10.0
var fireDelay = 0.0
export var fireRate = 2.0
var explosionPreset = preload("res://assets/graphic/effects/explosion.tscn")
var levelNode
var tankTowerSprite

func _ready():
	towerAudio = get_node("TowerAudio")
	tankTowerObject = get_node("Object")
	levelNode = get_node("/root/Level")
	tankTowerSprite = get_node("Object/AnimatedSprite2")
	
func _process(delta):
	if targetsInRange.size() == 0:
		var targetRotation = 90
		var rotation = tankTowerObject.rotation_degrees
		var difference = abs(rotation - targetRotation)
		if targetRotation > rotation:
			rotation += min(difference, towerTurnSpeed)
		else:
			rotation -= min(difference, towerTurnSpeed)
		tankTowerObject.rotation_degrees = rotation
	else:
		tankTowerSprite.rotation_degrees = - 90 - tankTowerObject.get_parent().get_parent().rotation_degrees 
		var targetX = targetsInRange[0].get_parent().get_position().x
		var targetY = targetsInRange[0].get_parent().get_position().y
		var distX = targetX - tankTowerObject.get_global_position().x
		var distY = targetY - tankTowerObject.get_global_position().y
		var targetRotation = rad2deg(atan2(distY,distX)) + 90;

		var rotation = tankTowerObject.rotation_degrees
		if targetRotation > 180 && rotation < 0:
			if rotation <=-90:
				tankTowerObject.rotation_degrees = 270
				rotation = 270
			else:
				targetRotation = -90
		elif targetRotation < 0 && rotation > 180:
			if rotation >=270:
				tankTowerObject.rotation_degrees = -90
				rotation = -90
			else:
				targetRotation = 270
				
		var difference = abs(rotation - targetRotation)
		if targetRotation > rotation:
			rotation += min(difference, towerTurnSpeed)
		else:
			rotation -= min(difference, towerTurnSpeed)
		tankTowerObject.rotation_degrees =  + rotation
		
		if difference < 5:
			if fireDelay <= 0:
				if Engine.time_scale == 1 || GlobalSettings.twoXSound:
					$TowerAudio.play()
				var projectile_temp = projectilePreset.instance()
				projectile_temp.rotation_degrees = tankTowerObject.rotation_degrees
				projectile_temp.direction = tankTowerObject.get_global_position().direction_to(targetsInRange[0].get_parent().get_position())
				projectile_temp.position = tankTowerObject.get_global_position() + projectile_temp.direction * 32
				projectile_temp.damage = projectileDamage
				levelNode.add_child(projectile_temp)
				fireDelay = fireRate
			else:
				fireDelay = fireDelay - delta


func _on_fireRange_body_entered(body):
	targetsInRange.append(body)


func _on_fireRange_body_exited(body):
	targetsInRange.erase(body)
