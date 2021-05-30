extends PathFollow2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var airplanePreset = [
	preload("res://assets/graphic/effects/airplane_formation_1.tscn"),
	preload("res://assets/graphic/effects/airplane_formation_2.tscn"),
	preload("res://assets/graphic/effects/airplane_formation_3.tscn"),
	preload("res://assets/graphic/effects/airplane_formation_4.tscn")
	]
var spawnTimer = 0;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	set_offset(get_offset() + 200 * delta)
	
	if spawnTimer <= 0:
		var rng = RandomNumberGenerator.new()
		rng.randomize()
		var maxSpawnAngle = 0;
		var minSpawnAngle = 0;
		if position.x >= 2111:
				#print("rechts")
				minSpawnAngle = 210
				maxSpawnAngle = 330
		elif position.x <=-255:
				#print("links")
				minSpawnAngle = 30;
				maxSpawnAngle = 150;
		elif position.y >= 1279:
				#print("unten")
				minSpawnAngle = -60;
				maxSpawnAngle = 60;
		elif position.y <=-191:
				#print("oben")
				minSpawnAngle = 120;
				maxSpawnAngle = 240;
				
		var spawnAngle = rng.randi_range(minSpawnAngle, maxSpawnAngle)
		var direction = Vector2(cos(spawnAngle), sin(spawnAngle))
		
		var presetId = randi() % airplanePreset.size() - 1
		var airplane_temp = airplanePreset[presetId].instance()
		for airplane in airplane_temp.get_children():
			airplane.rotation_degrees = spawnAngle
		airplane_temp.global_position = global_position #Vector2(500,500) 
		get_parent().add_child(airplane_temp)
		spawnTimer = 4
	else:
		spawnTimer -=delta
		
