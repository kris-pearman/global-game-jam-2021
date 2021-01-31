extends AudioStreamPlayer2D

func _ready():
	connect("finished", get_parent(), "queue_free")
