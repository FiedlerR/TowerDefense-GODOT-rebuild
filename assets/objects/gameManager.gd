extends Node

var collisions = 0
var health = 0
export var score = 0
var scoreLabel
var healthLabel
var buildingGhost
var buildingType = 0
var buildMode = true
var gameOver = true
var kills = 0
var buildingCost = [
	100,
	400,
	800,
	1200
]
var buildingGhostSprites = [
	preload("res://assets/graphic/buildings/tower_1/tower_1_ghost.png"),
	preload("res://assets/graphic/buildings/tower_2/tower_2_ghost.png"),
	preload("res://assets/graphic/buildings/tower_3/tower_3_ghost.png"),
	preload("res://assets/graphic/buildings/tower_4/tower_4_ghost.png"),
	preload("res://assets/graphic/buildings/sellIcon_ghost.png")
]
var buildingBlockedGhostSprites = [
	preload("res://assets/graphic/buildings/tower_1/tower_1_ghost_1.png"),
	preload("res://assets/graphic/buildings/tower_2/tower_2_ghost_1.png"),
	preload("res://assets/graphic/buildings/tower_3/tower_3_ghost_1.png"),
	preload("res://assets/graphic/buildings/tower_4/tower_4_ghost_1.png"),
	preload("res://assets/graphic/buildings/sellIcon_ghost_1.png")
]
var buildingPresets = [
	preload("res://assets/graphic/buildings/tower_1/tower_1.tscn"),
	preload("res://assets/graphic/buildings/tower_2/tower_2.tscn"),
	preload("res://assets/graphic/buildings/tower_3/tower_3.tscn"),
	preload("res://assets/graphic/buildings/tower_4/tower_4.tscn")
]

var fadeTextPreset = preload("res://assets/objects/fadeText.tscn")

func _ready():
	health = 100
	#score = 0
	buildingGhost = get_node("building_ghost")
	scoreLabel = get_node("/root/Level/HUD/Control/score")
	healthLabel = get_node("/root/Level/HUD/Control/health")
	score(500)

func _process(delta):
	if buildMode:
		if buildingType == 4:
			var collisionBodies = get_node("building_ghost/buildingCollision").get_overlapping_bodies()
			
			if collisionBodies.size() != 0 && collisionBodies[0].get_collision_layer() == 1025:
				if Input.is_action_just_pressed("mouse_left"):
					var posX = int(get_viewport().get_mouse_position().x/64) * 64 + 32
					var posY = int(get_viewport().get_mouse_position().y/64) * 64 + 32
					var sellValue = collisionBodies[0].get_parent().get_sell_value()
					score(sellValue)
					var fadeText_temp = fadeTextPreset.instance()
					fadeText_temp.get_node("fadeText").value = "+"+String(sellValue)
					fadeText_temp.position = Vector2(posX,posY)
					get_parent().add_child(fadeText_temp)
					collisionBodies[0].get_parent().sell()
				buildingGhost.set_texture(buildingGhostSprites[buildingType])
			else:
				buildingGhost.set_texture(buildingBlockedGhostSprites[buildingType])
			draw_build_ghost()
		else:
			collisions = get_node("building_ghost/buildingCollision").get_overlapping_bodies().size()
			draw_build_ghost()
			if collisions != 0:
				buildingGhost.set_texture(buildingBlockedGhostSprites[buildingType])
			else:
				buildingGhost.set_texture(buildingGhostSprites[buildingType])
				
			if Input.is_action_just_pressed("mouse_left") && collisions == 0 && score >= buildingCost[buildingType]:
				var tower_temp = buildingPresets[buildingType].instance()
				var posX = int(get_viewport().get_mouse_position().x/64) * 64 + 32
				var posY = int(get_viewport().get_mouse_position().y/64) * 64 + 32
				tower_temp.set_position(Vector2(posX,posY))
				tower_temp.sellValue = buildingCost[buildingType]
				add_child(tower_temp)
				score(-buildingCost[buildingType])
				redraw_ground()
				var fadeText_temp = fadeTextPreset.instance()
				fadeText_temp.get_node("fadeText").value = "-"+String(buildingCost[buildingType])
				fadeText_temp.position = Vector2(posX,posY)
				get_parent().add_child(fadeText_temp)
		if Input.is_action_pressed("mouse_right"):
			buildMode = false
			buildingGhost.visible = false
				#Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func damage(damage):
	health -= damage
	if health <= 0:
		gameOver = true
		get_node("../HUD/GameOver").visible = true
		get_node("../HUD/GameOver/Score").text = "SCORE: "+ String(score)
		get_node("../HUD/GameOver/Kills").text = "KILLS: "+ String(kills)
		Engine.time_scale = 0
		health = 0
	healthLabel.set_text(String(health) + String("%"))
	
func score(scorePoints):
	score += scorePoints
	scoreLabel.set_text(String(score) + String("$"))
	
func add_kill():
	kills += 1

func set_build_mode(build_mode):
	buildMode = build_mode
	
func set_building_type(building_type):
	buildingType = building_type
	buildingGhost.set_texture(buildingGhostSprites[buildingType])
	buildingGhost.visible = true
	
func draw_build_ghost():
	#Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	var posX = int(get_viewport().get_mouse_position().x/64) * 64 + 32
	var posY = int(get_viewport().get_mouse_position().y/64) * 64 + 32
	buildingGhost.set_position(Vector2(posX,posY))

func redraw_ground():
	var tileX = int(get_viewport().get_mouse_position().x/64)
	var tileY = int(get_viewport().get_mouse_position().y/64)
	var foregroundTileMap = get_node("/root/Level/foreground")
	foregroundTileMap.set_cell(tileX, tileY, -1)
	foregroundTileMap.update_dirty_quadrants()
