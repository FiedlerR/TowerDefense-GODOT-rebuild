extends Panel


func _ready():
	var highscore = 0
	var f = File.new()
	if f.file_exists("user://world"+String(GlobalSettings.world)+".dat"):
		f.open("user://world"+String(GlobalSettings.world)+".dat", File.READ)
		highscore = f.get_var()
		f.close()
	get_node("Highscore").text = "HIGHSCORE: " + String(highscore)
	
func _on_restart_pressed():
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
	get_tree().reload_current_scene()


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
