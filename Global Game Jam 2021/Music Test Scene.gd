extends Node2D

var num = -45
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.text = str(num)
	$Label/Intro.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed('right'):
		if num < -5:
			num += 0.1
	if Input.is_action_pressed('left'):
		if num >-44.9:
			num -= 0.1
	$Label.text = str(num)
	$"Label/Intro/Sober Layer".volume_db = num


func _on_Intro_finished():
	$"Label/Intro/Main Layer".play()
	$"Label/Intro/Sober Layer".play()
