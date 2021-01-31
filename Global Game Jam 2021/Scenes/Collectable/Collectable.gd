extends Area2D

export var id: int

func on_body_entered(body):
	if body.get_name() == "Player":
		body.play_cutscene(id)
		queue_free()

func _ready():
	if id == 0:
		$Sprite.texture = preload("res://Assets/Paintings/Chikoha.png")
	elif id == 1:
		$Sprite.texture = preload("res://Assets/Paintings/Swan Lake.png")
	connect("body_entered", self, "on_body_entered")
