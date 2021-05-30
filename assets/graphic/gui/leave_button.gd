extends TextureButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_leave_pressed():
	Engine.time_scale = 1
	var f = File.new()
	var last_highscore = 0
	var current_highscore = get_node("/root/Level/gameManager").score
	if f.file_exists("user://world"+String(GlobalSettings.world)+".dat"):
		f.open("user://world"+String(GlobalSettings.world)+".dat", File.READ)
		last_highscore = f.get_var()
		f.close()
	if current_highscore > last_highscore:
		f = File.new()
		f.open("user://world"+String(GlobalSettings.world)+".dat", File.WRITE)
		f.store_var(current_highscore)
		f.close()
	get_tree().change_scene("res://Mainmenu.tscn")
