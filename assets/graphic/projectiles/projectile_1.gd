extends Area2D


var direction
var timeTolive = 1.5
export var speed = 1000
export var damage = 20
export var showExplosionEffect = false
export var explosionEffect = preload ("res://assets/graphic/effects/explosion.tscn")
export var groundDestructionEffect = preload ("res://assets/graphic/effects/ground_destruction.tscn")
var root

# Called when the node enters the scene tree for the first time.
func _ready():
	root = get_node("/root/Level")


func _process(delta):
	if timeTolive > 0:
		timeTolive = timeTolive - delta
		set_position(get_position() + direction*speed*delta)
	else:
		create_ground_destruction_effect(null)
		create_explosion_effect(null)
		queue_free()


func _on_Projectile_body_entered(body):
	create_explosion_effect(body)
	create_ground_destruction_effect(body)
	body.get_parent().takeDamage(damage)
	queue_free()
	
func create_explosion_effect(var enemyBody):
	if showExplosionEffect:
		var explosionEffect_temp = explosionEffect.instance()
		if enemyBody == null:
			explosionEffect_temp.position = get_position()
			root.add_child(explosionEffect_temp)
		else:
			explosionEffect_temp.position = enemyBody.get_parent().get_position()
			root.add_child(explosionEffect_temp)

func create_ground_destruction_effect(var enemyBody):
	var groundDestructionEffect_temp = groundDestructionEffect.instance()
	if enemyBody == null:
		groundDestructionEffect_temp.position = get_position()
		root.add_child(groundDestructionEffect_temp)
	else:
		groundDestructionEffect_temp.position = enemyBody.get_parent().get_position()
		root.add_child(groundDestructionEffect_temp)

