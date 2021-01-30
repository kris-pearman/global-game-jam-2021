extends NinePatchRect

const player_distance: Vector2 = Vector2(200, 0) #TBD
const color_invisible: Color = Color(0, 0, 0, 0)

var timer: Timer

var direction: String = ""

func _ready():
	set_direction(direction)
	
	timer = Timer.new()
	timer.set_one_shot(true)
	timer.set_wait_time(5)
	timer.connect("timeout", self, "hide")
	add_child(timer)
	timer.start()

func set_direction(direction):
	match direction:
		"left":
			rect_position = player_distance * -1
		"right", _:
			rect_position = player_distance

func showText(text, direction = ""):
	$Label.text = text
	set_direction(direction)

func hide():
	#May seem redundant. Leaving hide function in case we want to make bubbles fade before disappearing
	queue_free()
