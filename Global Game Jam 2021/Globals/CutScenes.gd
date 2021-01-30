extends Node

var scene_array: Array = []
var current_scene: Array

func _ready():
	var scene0: Array = ["test message one", "test message two"]
	scene_array.push_back(scene0)

func play_scene(id):
	current_scene = scene_array[0]

func get_next_message():
	if(current_scene.size() > 0):
		return current_scene.pop_front()
	else:
		return ""
