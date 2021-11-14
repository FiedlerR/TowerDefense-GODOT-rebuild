extends PathFollow2D

export var defaultSpeed = 80
export var healthpoints = 100
export var damagepoints = 10
export var scorepoints = 20
export var showExplosionEffect = false
export var explosionEffect = preload ("res://assets/graphic/effects/explosion.tscn")
var gameManager
var alive = true
signal enemy_despawned
var fadeTextPreset = preload("res://assets/objects/fadeText.tscn")
var levelNode

func _ready():
	gameManager = get_node("/root/Level/gameManager")
	levelNode = get_node("/root/Level")
	
func _process(delta):
	if alive:
		set_offset(get_offset() + defaultSpeed * delta)
		
		if get_unit_offset() >= 1:
			if gameManager != null:
				gameManager.damage(damagepoints)
			get_parent().decrease_remaining_enemies()
			alive = false
			queue_free()

func takeDamage(damage):
	if alive:
		if get_node_or_null("KinematicBody2D/Node2D") && !get_node("KinematicBody2D/Node2D").visible:
			get_node("KinematicBody2D/Node2D").visible = true
			get_node("KinematicBody2D/Node2D/health_foreground").max_value = healthpoints
		healthpoints -= damage
		if get_node_or_null("KinematicBody2D/Node2D"):
			get_node("KinematicBody2D/Node2D/health_foreground").value = healthpoints
		if healthpoints <= 0:
			if showExplosionEffect:
				var explosionEffect_temp = explosionEffect.instance()
				explosionEffect_temp.position = get_global_position()
				levelNode.add_child(explosionEffect_temp)
			var fadeText_temp = fadeTextPreset.instance()
			fadeText_temp.get_node("fadeText").value = "+" + String(scorepoints)
			fadeText_temp.position = position
			get_parent().add_child(fadeText_temp)
			get_parent().decrease_remaining_enemies()
			gameManager.score(scorepoints)
			gameManager.add_kill()
			alive = false
			queue_free()
		
func getNextPosition():
	return get_offset() + defaultSpeed * 1
