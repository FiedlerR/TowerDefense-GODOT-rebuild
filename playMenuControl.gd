extends Control


var screenWidth = 0
var screenHeight = 0
var selectedScene = 0
var levelPreviewControllerX = 0;
var menuSpeed = 0.05
var maxLevel = 6
var levelPreviewPreset = preload("res://assets/objects/levelPreview.tscn")
var levelPath = [
	"res://assets/level/level_1/level_1.tscn",
	"res://assets/level/level_2/level_2.tscn",
	"res://assets/level/level_3/level_3.tscn",
	"res://assets/level/level_4/level_4.tscn",
	"res://assets/level/level_5/level_5.tscn",
	"res://assets/level/level_6/level_6.tscn"
]
var levelPreviewImage = [
	preload("res://assets/level/level_1/preview.png"),
	preload("res://assets/level/level_2/preview.png"),
	preload("res://assets/level/level_3/preview.png"),
	preload("res://assets/level/level_4/preview.png"),
	preload("res://assets/level/level_5/preview.png"),
	preload("res://assets/level/level_6/preview.png")
]

# Called when the node enters the scene tree for the first time.
func _ready():
	screenWidth = get_viewport_rect().size.x
	screenHeight = get_viewport_rect().size.y
	
	for i in range(maxLevel):
		var levelPreview = levelPreviewPreset.instance()
		levelPreview.set_position(Vector2(-screenWidth/2+i*screenWidth, -screenHeight/2))
		levelPreview.get_node("Panel/TextureRect").texture = levelPreviewImage[i]
		var f = File.new()
		var highscore = 0
		if f.file_exists("user://world"+String(i)+".dat"):
			f.open("user://world"+String(i)+".dat", File.READ)
			highscore = f.get_var()
			f.close()
		levelPreview.get_node("highscore").text = "highscore: " + String(highscore)
		get_node("levelPreviewController").add_child(levelPreview)


func _process(delta):
	if levelPreviewControllerX != selectedScene*screenWidth:
		levelPreviewControllerX = lerp(levelPreviewControllerX,selectedScene*screenWidth, menuSpeed)
		$levelPreviewController.set_position(Vector2(-levelPreviewControllerX,0))

func _on_startgame_pressed():
	GlobalSettings.world = selectedScene
	get_tree().change_scene(levelPath[selectedScene])


func _on_scrollToLeft_pressed():
	if selectedScene > 0:
			selectedScene-=1


func _on_scrollToRight_pressed():
	if selectedScene < maxLevel-1:
		selectedScene +=1



func _on_continuegame_pressed():
	get_tree().change_scene("user://my_scene.tscn")
