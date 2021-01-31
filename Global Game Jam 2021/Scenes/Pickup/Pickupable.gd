extends Node2D

export var type = "none"
export var value = 0


func _ready():
	if type == "booze":
		$Sprite.texture = preload("res://Assets/Player/Cutouts/Bottle.png")
	Events.connect("player_collided_with_pickup",self,"on_pickup")


func on_pickup(object):
	if object == self:
		queue_free()

