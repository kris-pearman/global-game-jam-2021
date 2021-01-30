extends TileMap

var player: KinematicBody2D

func _ready():
	player = get_node("YSort/Node2D")

func teleport_to(teleport_id):
	pass
