extends Panel

var gameManager

func _ready():
	gameManager = get_node("/root/Level/gameManager")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_buildIcon_1_pressed():
	gameManager.set_build_mode(true)
	gameManager.set_building_type(0)


func _on_buildIcon_2_pressed():
	gameManager.set_build_mode(true)
	gameManager.set_building_type(1)


func _on_buildIcon_3_pressed():
	gameManager.set_build_mode(true)
	gameManager.set_building_type(2)


func _on_buildIcon_4_pressed():
	gameManager.set_build_mode(true)
	gameManager.set_building_type(3)


func _on_sellIcon_pressed():
	gameManager.set_build_mode(true)
	gameManager.set_building_type(4)
