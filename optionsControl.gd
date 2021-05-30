extends Control


var settings_file = "user://settings.save"


# Called when the node enters the scene tree for the first time.
func _ready():
	load_settings()
	if !OS.window_fullscreen:
		get_node("Label6/Off/Label9").text = "OFF"
	else:
		get_node("Label6/Off/Label9").text = "ON"
	get_node("Label6/Off").pressed = !OS.window_fullscreen

	if !GlobalSettings.twoXSound:
		get_node("Label/Off_2xsound/Label9").text = "OFF"
	else:
		get_node("Label/Off_2xsound/Label9").text = "ON"
	get_node("Label/Off_2xsound").pressed = !GlobalSettings.twoXSound

	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), GlobalSettings.masterVolume)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), GlobalSettings.musicVolume)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Sfx"), GlobalSettings.sfxVolume)
	
	get_node("Label5/master_slider3").value = GlobalSettings.masterVolume
	get_node("Label3/music_slider2").value = GlobalSettings.musicVolume
	get_node("Label2/sfx_slider").value = GlobalSettings.sfxVolume
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func save_settings():
	var f = File.new()
	f.open(settings_file, File.WRITE)
	f.store_var(OS.window_fullscreen)
	f.store_var(GlobalSettings.twoXSound)
	f.store_var(GlobalSettings.sfxVolume)
	f.store_var(GlobalSettings.musicVolume)
	f.store_var(GlobalSettings.masterVolume)
	f.close()

func load_settings():
	var f = File.new()
	if f.file_exists(settings_file):
		f.open(settings_file, File.READ)
		OS.window_fullscreen = f.get_var()
		GlobalSettings.twoXSound = f.get_var()
		GlobalSettings.sfxVolume = f.get_var()
		GlobalSettings.musicVolume = f.get_var()
		GlobalSettings.masterVolume = f.get_var()
		f.close()

func _on_Off_toggled(button_pressed):
	if button_pressed:
		get_node("Label6/Off/Label9").text = "OFF"
	else:
		get_node("Label6/Off/Label9").text = "ON"
	OS.window_fullscreen = !button_pressed


func _on_Off_2xsound_toggled(button_pressed):
	if button_pressed:
		get_node("Label/Off_2xsound/Label9").text = "OFF"
	else:
		get_node("Label/Off_2xsound/Label9").text = "ON"
	GlobalSettings.twoXSound = !button_pressed


func _on_master_slider3_value_changed(value):
	GlobalSettings.masterVolume = value
	if value > -24:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), false)
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)
	else:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), true)


func _on_music_slider2_value_changed(value):
	GlobalSettings.musicVolume = value
	if value > -24:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Music"), false)
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), value)
	else:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Music"), true)


func _on_sfx_slider_value_changed(value):
	GlobalSettings.sfxVolume = value
	if value > -24:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Sfx"), false)
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Sfx"), value)
	else:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Sfx"), true)


func _on_save_pressed():
	get_node("flash_label").visible = true
	save_settings()
