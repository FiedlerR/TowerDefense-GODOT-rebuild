extends Node2D

export var timeTolive = 10
export var textureId = -1
var groundDestructionSprites = [
	preload("res://assets/graphic/effects/ground_destruction_1.png"),
	preload("res://assets/graphic/effects/ground_destruction_2.png"),
	preload("res://assets/graphic/effects/ground_destruction_3.png")
]

# Called when the node enters the scene tree for the first time.
func _ready():
	if textureId == -1:
		textureId = randi() % 3
	$Sprite.texture = groundDestructionSprites[textureId]

func _process(delta):
	if timeTolive > 0:
		timeTolive = timeTolive - delta
	else:
		queue_free()
