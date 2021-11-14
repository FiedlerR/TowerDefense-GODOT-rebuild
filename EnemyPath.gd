extends Path2D

var timer = 0
export var spawnTime = 0.5

var enemyPresets = [
	preload("res://assets/graphic/enemies/enemy_1/enemy_1.tscn"),
	preload("res://assets/graphic/enemies/enemy_2/enemy_2.tscn"),
	preload("res://assets/graphic/enemies/enemy_3/enemy_3.tscn"),
	preload("res://assets/graphic/enemies/enemy_4/enemy_4.tscn"),
	preload("res://assets/graphic/enemies/enemy_5/enemy_5.tscn")
]
var wave = 0
var spawnList = []
var remainingEnemies = 0
export var isInMainMenu = false
var timeToliveDefault = 2
var timeTolive = 1.5
var isWaveMessageActive = false
var waveMessageBox
var waveDelay = 5
var waveDelayValue = 5

func _ready():
	randomize()
	if !isInMainMenu:
		waveMessageBox = get_node("/root/Level/HUD/waveMessage")
	
func _process(delta):
	#print(remainingEnemies)
	if timeTolive > 0:
		timeTolive = timeTolive - delta
	elif !isInMainMenu:
		waveMessageBox.visible = false
		isWaveMessageActive = false

	timer += delta
	
	#print("wave: "+String(wave)+ " | "+" enemies: " + String(remainingEnemies))
	if spawnList.size() > 0:
		_spawner()
	
	if remainingEnemies == 0 && spawnList.size() == 0:
		if timeTolive <= 0:
			wave +=1
			show_wave_Message()
			waveDelay = waveDelayValue
		else:
			if wave == 1:
				spawnList = [1,1,1,1,1,1,1,1,1]
			elif wave == 2:
				spawnList = [1,1,1,1,1,1,1,1,1,1,1,1]
			elif wave == 3:
				spawnList = [5,1,1,1,2,1,1,1,1,1,1,1,2,1,1,1,1,2]
			elif wave == 4:
				spawnList = [2,2,2,1,1,1,1,1,1,1,1,1,1,1,1,1,2,2,2,1,1,1,1,1,1]
			elif wave == 5:
				spawnList = [3,3,2,2,2,2,2,2,2,2,1,1,5,1,1,1,1,2,2,2,2,2,1,1,1,1,1,
				1,1,1,1,1,3,3,3,3,3,3,3,1,1,1,1,]
			elif wave == 6:
				spawnList = [3,2,3,2,3,2,3,2,3,2,3,2,3,1,1,1,1,1,1,2,2,2,2,2,3]
			elif wave == 7:
				spawnList = [4,1,1,1,1,1,3,1,1,1,1,2,1,1,1,1,1,4,4,4,4,4,1,1,1,1,1,
				2,2,2,2,2,2,2,2,4,3,3,3,3,3,3,3,1]
			elif wave == 8:
				spawnList = [5,5,5,5,5,4,4,4,4,4,4,4,4,4,4,4,1,1,1,1,1,1,1,1,1,1,1,
				2,2,2,2,2,2,2,2,2,3,2,2,2,2,2,2,3,2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
				1,1]
			elif wave == 9:
				spawnList = [4,3,2,1,4,3,2,5,4,3,2,1,1,1,1,1,1,2,2,2,2,2,5,2,2,2,2,2,
				2,4,1,1,1,1,1,4,1,1,1,1,1,1,1,5,3,3,3,3,3,3,5,3,3,3,3,3,3,5,3,3,3,4]
			elif wave == 10:
				spawnList = [4,3,2,1,4,3,2,5,4,3,2,5,4,4,4,5,4,4,2,3,2,3,2,3,2,3,2,3,2,
				3,4,4,5,4,4,4,4,4,5,4,4,4,5,4,4,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,4]
			elif wave > 10:
				create_spawn_list();
			remainingEnemies = spawnList.size()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _spawner():
	if timer > spawnTime:
		var newEnemy = enemyPresets[spawnList[0]-1].instance()
		spawnList.remove(0)
		#remainingEnemies+=1
		add_child(newEnemy)
		timer = 0
		
func decrease_remaining_enemies():
		remainingEnemies-=1
	
func create_spawn_list():
	
	for i in range(wave*2):
		var random = randf()
		if random < 0.40:
			spawnList.append(5)
		if random < 0.85:
			spawnList.append(4)
		elif random < 0.90:
			spawnList.append(3)
		elif random < 0.95:
			spawnList.append(2)
		else:
			spawnList.append(1)
			
	#print(spawnList)
			
func show_wave_Message():
		timeTolive = timeToliveDefault
		if !isInMainMenu:
			waveMessageBox.visible = true
			isWaveMessageActive = true
			waveMessageBox.get_node("Panel/waveLabel").text = "WAVE " + String(wave)
