extends PathFollow2D

export var defaultSpeed = 80
export var healthpoints = 100
export var damagepoints = 10
export var scorepoints = 20
var gameManager
var alive = true
signal enemy_despawned
var fadeTextPreset = preload("res://assets/objects/fadeText.tscn")

func _ready():
	gameManager = get_node("/root/Level/gameManager")

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
		healthpoints -= damage
		if healthpoints <= 0:
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
