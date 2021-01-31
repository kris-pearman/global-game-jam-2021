extends Area2D

export var id: int

func on_body_entered(body):
	if body.get_name() == "Player":
		body.play_cutscene(id)
		$AudioStreamPlayer2D.play()

func _ready():
	if id == 0:
		$Sprite.texture = preload("res://Assets/Paintings/Chikoha.png")
		$AudioStreamPlayer2D.stream = preload("res://Sounds/Find painting 1.wav")
	elif id == 1:
		$Sprite.texture = preload("res://Assets/Paintings/Swan Lake.png")
		$AudioStreamPlayer2D.stream = preload("res://Sounds/Find painting 2.wav")
	else:
		$AudioStreamPlayer2D.stream = preload("res://Sounds/Find painting 3.wav")
	connect("body_entered", self, "on_body_entered")
