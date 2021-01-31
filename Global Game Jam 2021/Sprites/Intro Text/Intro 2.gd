extends Node2D

var active = false
var timer1 = false
var timer1active = false
var line2 = false
var line3 = false
var fadeout = false



func _ready():
	set_fade_active()


func set_fade_active():
	active = true


func _process(delta):
	if fadeout == false:
		if active == true:
			#color[3] += 0.01
			$ColorRect.color[3]-= delta / 2
		if $ColorRect.color[3] < 1 and timer1active == false:
			timer1 = true
			timer1active = true
			$"Line 2".start()
		if line2 == true:
			$ColorRect2.color[3]-= delta / 2
		if line3 == true:
			$ColorRect3.color[3]-= delta / 2
	else:
		$ColorRect.color[3]+= 0.025
		$ColorRect2.color[3]+= 0.025
		$ColorRect3.color[3]+= 0.025


func _on_Line_2_timeout():
	line2 = true
	$"Line 3".start()


func _on_Line_3_timeout():
	line3 = true
	$"Line 4".start()
	

func _on_Line_4_timeout():
	fadeout = true
	$ColorRect.color[3] = 0
	$ColorRect2.color[3] = 0
	$ColorRect3.color[3] = 0
	$"Change Slide".start()


func _on_Change_Slide_timeout():
	get_tree().change_scene("res://Sprites/Intro Text/Instructions.tscn")
