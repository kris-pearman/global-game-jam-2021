extends ColorRect


var active = false


func _ready():
	Events.connect("game_over",self,"set_fade_active")


func set_fade_active():
	active = true


func _process(delta):
	if active == true:
		#color[3] += 0.01
		color[3] += delta / 2

