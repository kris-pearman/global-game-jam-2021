extends Node



func _ready():
	Events.connect("player_collided_with_pickup",self,"on_pickup")


func on_pickup(type,value):
	get_parent().queue_free()
