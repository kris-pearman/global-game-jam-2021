extends Node2D



func _ready():
	Events.connect("player_collided_with_pickup",self,"on_pickup")


func on_pickup(type,value):
	queue_free()
