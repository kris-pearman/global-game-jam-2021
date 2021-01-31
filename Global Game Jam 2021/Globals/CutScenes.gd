extends Node

var scene_array: Array = []
var current_scene: Array

func _ready():
	var scene0: Array = [
		"It was a sunny day \njust like this.",
		"Still air, muffled \nfootsteps, the gentle give \nof a brush on canvas.",
		"So peaceful, but at \n the same time brimming with life.\nStreets echoing with the chatter \nof passersby,",
		"their excitement sending ripples \nthrough the calm water's \nswell.",
		"Yet spring came, \nand their presence faded. \nColors dimmed, \nlines lost definition,",
		"shadows haunted \nmy fragile landscapes.",
		"A part of the world \nhad been lost, \neven as frost gave way to flowers.",
		"After all, there was \nno point in the beauty\n of blossoming petals",
		"if no one was around \nto enjoy them."
		]
	var scene1: Array = [
		"Beautiful things were only \nbeautiful because they \ndidn't last.",
		"I think that's what brought\n  a father and his \ndaughter to my side \nunder this far-reaching",
		"testament to some bygone glory.",
		"Yet, despite the sight towering \nbefore them, their eyes were \ntransfixed to its likeness \non my canvas,",
		"the impermanent vision \nof a lone artist.",
		"Sitting on a nearby ledge, \nice cream kissing the \nyoung girl's nose,",
		"the two of them watched\n the colors take shape.",
		"When finished, the father paid me \nfar too much for the painting,\nand the daughter beheld \nthe textured oils with awe.",
		"There was no doubt. \nThey had seen that same \nspecial thing in the world as I did.",
		"If only I could remember what \n that was."
	]
	var scene2: Array = []
	scene_array.push_back(scene0)
	scene_array.push_back(scene1)
	scene_array.push_back(scene2)

func play_scene(id):
	current_scene = scene_array[id]

func get_next_message():
	if(current_scene.size() > 0):
		return current_scene.pop_front()
	else:
		return ""
