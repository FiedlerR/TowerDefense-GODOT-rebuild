extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if (menuState == 1 || menuState == 2 || menuState == 3) && mainmenuY > -1080:
		mainmenuY = lerp(mainmenuY,-1080, menuSpeed)
		$mainmenuControl.set_position(Vector2(0,mainmenuY))
	if (menuState == 0) && mainmenuY != 0:
		mainmenuY = lerp(mainmenuY,0, menuSpeed)
		$mainmenuControl.set_position(Vector2(0,mainmenuY))
		
		if optionsmenuY != 1080:
			optionsmenuY = lerp(optionsmenuY,1080, menuSpeed)
			$optionsControl.set_position(Vector2(0,optionsmenuY))
			
		if creditsmenuY != 1080:
			creditsmenuY = lerp(creditsmenuY,1080, menuSpeed)
			$creditsControl.set_position(Vector2(0,creditsmenuY))
			
		if playmenuY != 1080:
			playmenuY = lerp(playmenuY,1080, menuSpeed)
			$playControl.set_position(Vector2(0,playmenuY))
		
	if (menuState == 1) && playmenuY != 0:
		playmenuY = lerp(playmenuY,0, menuSpeed)
		$playControl.set_position(Vector2(0,playmenuY))
		
	if (menuState == 2) && optionsmenuY != 0:
		optionsmenuY = lerp(optionsmenuY,0, menuSpeed)
		$optionsControl.set_position(Vector2(0,optionsmenuY))
		
	if (menuState == 3) && creditsmenuY != 0:
		creditsmenuY = lerp(creditsmenuY,0, menuSpeed)
		$creditsControl.set_position(Vector2(0,creditsmenuY))
		
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	passss
var menuState = 0
var mainmenuY = 0
var playmenuY = 1080
var optionsmenuY = 1080
var creditsmenuY = 1080
var menuSpeed = 0.05

func _on_play_pressed():
	menuState = 1

func _on_settings_pressed():
	menuState = 2

func _on_credits_pressed():
	menuState = 3


func _on_backToMainmenu_pressed():
	get_node("optionsControl/flash_label").visible = false
	menuState = 0;

