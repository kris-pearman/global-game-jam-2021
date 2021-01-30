extends ProgressBar



func _ready():
	value = 100
	Events.connect("player_collided_with_pickup",self,"on_pickup")


func on_pickup(object):
	value += object.value
