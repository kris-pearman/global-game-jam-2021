extends Area2D

export var id: int

func on_body_entered(body):
	if body.get_name() == "Player":
		body.play_cutscene(id)

func _ready():
	connect("body_entered", self, "on_body_entered")
