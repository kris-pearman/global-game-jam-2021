extends Node

func _input(event):
	if event.is_action_pressed('ui_cancel'):
		get_tree().change_scene("res://Scenes/Screens/End.tscn")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Intro.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Intro_finished():
	$Main.play()
