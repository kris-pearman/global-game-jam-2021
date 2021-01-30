extends Node

var maps: Array
var current_map: TileMap

func _ready():
	#map array index works as their teleport id
	maps = [
		preload("res://Scenes/Map/Map.tscn"),
		preload("res://Scenes/Map/Map2.tscn")
	]
	
	Events.connect("player_teleported", self, "on_teleport")
	current_map = maps[0].instance()
	add_child(current_map)

func on_teleport(map_id, teleport_id):
	current_map.queue_free()
	current_map = maps[map_id].instance()
	add_child(current_map)
