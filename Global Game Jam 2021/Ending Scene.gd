extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	$AnimationPlayer.play("Fade 0")
	$Timer.stop()


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Fade 0":
		$AnimationPlayer.play("Fade 1")
	if anim_name == "Fade 1":
		$AnimationPlayer.play("Fade 2")
	if anim_name == "Fade 2":
		$AnimationPlayer.play("Fade 3")
	if anim_name == "Fade 3":
		$AnimationPlayer.play("Fade 4")
	if anim_name == "Fade 4":
		$AnimationPlayer.play("Fade 5")
	if anim_name == "Fade 5":
		$AnimationPlayer.play("Fade 6")
	if anim_name == "Fade 6":
		$AnimationPlayer.play("Fade 7")
	if anim_name == "Fade 7":
		get_tree().change_scene("res://Scenes/Screens/Title.tscn")
